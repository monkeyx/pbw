module Pbw
	class RegistrationsController < Devise::RegistrationsController
		after_filter :add_user, :only => [:create]

		protected

		def add_user
			if resource.persisted?
				Pbw::Engine.user_lifecycle_class.after_signup(resource)
			end
		end
	end
end