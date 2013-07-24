module Pbw
	class SessionsController < Devise::SessionsController
		after_filter :login_user, :only => [:create]

		protected

		def login_user
			Pbw::Engine.user_lifecycle_class.after_signup(current_user)
		end
	end
end