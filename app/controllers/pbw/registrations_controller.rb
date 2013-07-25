module Pbw
	class RegistrationsController < Devise::RegistrationsController
		respond_to :json

		def create
			self.resource = User.new(params[:user])
			logger.error "Password confirmed? #{params[:user][:password] == params[:user][:password_confirmation]}"
			if resource.save
				User::Lifecycle.after_signup(resource)
				render json: resource
			else
				render json: resource.errors.full_messages.to_json, status: :unprocessable_entity
			end
		end
	end
end