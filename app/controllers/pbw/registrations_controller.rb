module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json

		def create
			build_resource(params[:user])
			if resource.save
				if resource.active_for_authentication?
					Pbw::Engine.user_lifecycle_class.after_signup(current_user)
					render json: current_user
				else
					logger.error "Not active_for_authentication"
					expire_session_data_after_sign_in!
					head :no_content
				end
			else
				logger.error "Unable to save resource:\n #{resource.errors.full_messages}"
				clean_up_passwords resource
				render json: {errors: resource.errors.full_messages}, status: :unprocessable_entity
			end
		end
	end
end