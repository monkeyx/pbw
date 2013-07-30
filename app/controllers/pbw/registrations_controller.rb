module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json
		wrap_parameters format: [:json]

		def create
			self.resource = User.new(params)
			if resource.save && resource.send_registration_email
				Pbw.user_lifecycle_class.after_signup(resource)
				render json: resource
			else
				render json: resource.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end
	end
end