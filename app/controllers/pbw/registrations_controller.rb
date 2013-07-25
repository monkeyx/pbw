module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json

		def create
			self.resource = User.new(params[:user])
			logger.error "Password confirmed? #{params[:user][:password] == params[:user][:password_confirmation]}"
			if resource.save
				if resource.active_for_authentication?
					Pbw::Engine.user_lifecycle_class.after_signup(resource)
					render json: resource
				else
					expire_session_data_after_sign_in!
					head :no_content
				end
			else
				render json: resource.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end
	end
end