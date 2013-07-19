module Pbw
	class BaseModelsController < ApplicationController
		respond_to :json

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
			respond_with(@models) do |format|
				format.json { render json: @models }
			end
		end

		def show
			respond_with(@model) do |format|
				format.json { render json: @model }
			end
		end

		def edit
			respond_with(@model) do |format|
				format.json { render json: @model }
			end
		end

		def new
			respond_with(@model) do |format|
				format.json { render json: @model }
			end
		end

		def create
			if @model.save
				respond_with(@model) do |format|
					format.json { render json: @model }
				end
			else
				respond_with(@model) do |format|
					format.json { render json: @model.errors.full_messages, status: :unprocessable_entity}
				end
			end
		end

		def update
			if @model.update_attributes(params[model_param])
				respond_with(@model) do |format|
					format.json { render json: @model }
				end
			else
				respond_with(@model) do |format|
					format.json { render json: @model.errors.full_messages, status: :unprocessable_entity}
				end
			end
		end

		def destroy
			if @model.destroy
				respond_with(@model) do |format|
					format.json { head :no_content }
				end
			else
				respond_with(@model) do |format|
					format.json { render json: @model.errors.full_messages, status: :unprocessable_entity}
				end
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
			authorize! :manage, model_class
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