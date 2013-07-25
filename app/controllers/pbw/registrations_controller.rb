module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json

		def create
			build_resource(sign_up_params)

			if resource.save
				if resource.active_for_authentication?
					sign_up(resource_name, resource)
					Pbw::Engine.user_lifecycle_class.after_signup(current_user)
					render json: current_user
				else
					expire_session_data_after_sign_in!
					head :no_content
				end
			else
				clean_up_passwords resource
				render json: resource.errors.full_messages, status: :unprocessable_entity
			end
		end
	end
end