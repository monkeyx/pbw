module Pbw
	class SessionsController < Devise::SessionsController
		respond_to :json

		def create
			self.resource = warden.authenticate!(auth_options)
			sign_in(resource_name, resource)
			::User::Lifecycle.after_login(current_user)
			respond json: current_user.to_json, status: :ok
		end

		def after_sign_out_path_for(resource_name)
			"/"
		end
	end
end