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
	  		if @models && !@models.empty?
				render json: @models.to_json
			else
				render json: '', status: :unprocessable_entity
			end
		end

		def show
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
			if @model.update_attributes(params)
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
					klass = class_from_string(params[:_type])
					return klass if klass.ancestors.include?(self.model_class)
				end
			rescue Exception => e
				logger.error "Unable to determine real model class from _type: #{params[:_type]}"
				logger.error e
			end
			self.model_class
		end

		def model_id
			params[:id]
		end

		def index_scope
			scope = real_model_class.scoped.desc(:created_at)
			unless params[:scope].blank?
				scope = scope.send(params[:scope].to_sym)
			end
			if params[:scopes]
				params[:scopes].each do |sc|
					scope = scope.send(sc.to_sym)
				end
			end
			if params[:where]
				size = params[:where].size
				(0..(size-1)).each do |n|
					scope = scope.where(params[:where][n][:name] => params[:where][n][:value])
				end
			end
			unless params[:asc].blank?
				scope = scope.asc(params[:asc].to_sym)
			end
			unless params[:desc].blank?
				scope = scope.desc(params[:desc].to_sym)
			end
			unless params[:page].blank?
				limit = params[:limit].blank? ? 10 : params[:limit].to_i
				skip = (params[:page].to_i - 1) * limit
				scope = scope.skip(skip).limit(limit)
			else
				if params[:limit]
					scope = scope.limit(params[:limit])
				end
			end
			scope
		end

		def index_models
			authorize! :index, real_model_class
			@models = index_scope
		end

		def model_for_create
			authorize! :create, real_model_class
			@model = real_model_class.new(params)
			@model.accessible = :all
			update_model_before_create(@model)
		end

	  	def model_for_read
			@model = real_model_class.find(model_id)
			authorize! :read, @model
		end

		def model_for_update
			@model = real_model_class.find(model_id)
			authorize! :update, @model
			@model.accessible = :all
			update_model_before_update(@model)
		end

		private
		def class_from_string(str)
		  str = str.gsub('::','  ').strip.gsub('  ', '::')	
		  str.split('::').inject(Object) do |mod, class_name|
		    mod.const_get(class_name)
		  end
		end
	end

end