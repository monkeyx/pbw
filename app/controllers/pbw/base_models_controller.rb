module Pbw
	class BaseModelsController < BaseController
		attr_accessor :model_class

		before_filter :authenticate_user!
		before_filter :set_model_class
		before_filter :model_for_read, :only => [:show]
		before_filter :model_for_update, :only => [:edit, :update, :destroy]
		before_filter :index_models, :only => [:index]
		before_filter :model_for_create, :only => [:new, :create]

		def set_model_class
			# stub method
		end

		def update_model_before_create(model)
			# stub method
		end

		def update_model_before_update(model)
			# stub method
		end

		def index
	  		session[:referrer] = request.url
	  		render json: @models
		end

		def show
			render json: @model.to_json
		end

		def edit
			render json: @model.to_json
		end

		def new
			render json: @model.to_json
		end

		def create
			if @model.save
				render json: @model.to_json
			else
				render json: @model.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end

		def update
			if @model.update_attributes(params[model_param])
				render json: @model.to_json
			else
				render json: @model.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end

		def destroy
			if @model.destroy
				head :no_content
			else
				render json: @model.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end

		def real_model_class
			begin
				unless params[:_type].blank?
					klass = Kernel.get_const(params[:_type])
					return klass if klass.ancestors.include?(self.model_class)
				end
			rescue
			end
			self.model_class
		end

		def model_param
			model_class.name.underscore.downcase.to_sym
		end

		def model_id
			params[:id]
		end

		def index_models
			authorize! :manage, real_model_class
			@models = model_class.desc(:created_at)
		end

		def model_for_create
			authorize! :create, real_model_class
			@model = real_model_class.new(params[model_param])
			update_model_before_create(@model)
		end

	  	def model_for_read
			@model = model_class.find(model_id)
			authorize! :read, @model
		end

		def model_for_update
			@model = model_class.find(model_id)
			authorize! :update, @model
			update_model_before_update(@model)
		end
	end

end