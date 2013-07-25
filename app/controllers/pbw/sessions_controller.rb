module Pbw
	class SessionsController < Devise::SessionsController
		respond_to :json

		def create
			self.resource = warden.authenticate!(auth_options)
			sign_in(resource_name, resource)
			Pbw::Engine.user_lifecycle_class.after_login(current_user)
			respond json: current_user
		end
	end
end