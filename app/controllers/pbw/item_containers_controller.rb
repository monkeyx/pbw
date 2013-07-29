module Pbw
	class ItemContainersController < BaseModelsController
		def set_model_class
			self.model_class = ItemContainer
		end

		def real_model_class
			self.model_class
		end

		def token_or_area_or_user
			return @token_or_area_or_user if defined?(@token_or_area_or_user) && @token_or_area_or_user
			begin
				unless params[:_type].blank?
					klass = Kernel.get_const(params[:_type])
					return @token_or_area_or_user = klass.find(params[:container_id])
				else
					return @token_or_area_or_user = current_user
				end
			rescue
				nil
			end
		end

		def index_models
			authorize! :read, token_or_area_or_user
			@models = token_or_area_or_user.item_containers
		end

		def model_for_create
			authorize! :update, token_or_area_or_user
			@model = model_class.new(params[model_param])
			if token_or_area_or_user.ancestors.include?(Area)
				@model.area = token_or_area_or_user
			elsif token_or_area_or_user.ancestors.include?(Token)
				@model.token = token_or_area_or_user
			elsif token_or_area_or_user.ancestors.include?(User)
				@model.user = token_or_area_or_user
			end
			update_model_before_create(@model)
		end
	end
end