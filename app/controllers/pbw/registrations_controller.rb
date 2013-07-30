module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json
		
		def create
			self.resource = User.new(params)
			if resource.save && resource.send_registration_email
				unwrapped = params
				params[:user] = unwrapped
				Pbw.user_lifecycle_class.after_signup(resource)
				sign_in(:user, resource)
				render json: resource
			else
				render json: resource.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end
	end
end