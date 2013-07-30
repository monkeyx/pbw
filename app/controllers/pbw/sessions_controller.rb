module Pbw
	class SessionsController < Devise::SessionsController
		respond_to :json
		wrap_parameters format: [:json]

		def create
			self.resource = warden.authenticate!(auth_options)
			sign_in(resource_name, resource)
			Pbw.user_lifecycle_class.after_login(current_user)
			render json: current_user.to_json, status: :ok
		end

		def destroy
			signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
			render json: '', status: :ok
		end
	end
end