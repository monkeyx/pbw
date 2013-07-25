module Pbw
	class PasswordsController < Devise::PasswordsController
		respond_to :json

		def create
			self.resource = resource_class.where(resource_params)
			if resource.reset_password!
				head :no_content
			else
				render status: :unprocessable_entity
			end
		end
	end
end