module Pbw
	class PasswordsController < Devise::PasswordsController
		respond_to :json
		wrap_parameters format: [:json]

		def create
			self.resource = resource_class.where(params).first
			if resource && resource.reset_password!
				head :no_content
			else
				render status: :unprocessable_entity
			end
		end
	end
end