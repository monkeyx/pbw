module Pbw
	class RegistrationsController < Devise::RegistrationsController
		after_filter :add_user, :only => [:create]

		protected

		def add_user
			if current_user
				Pbw::Engine.user_lifecycle_class.after_signup(current_user) 
				render json: current_user
			end
		end
	end
end