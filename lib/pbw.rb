require "pbw/engine"

module Pbw
	def self.email_from_address
		Engine.config.email_from_address
	end

	def self.email_from_address=(email)
		Engine.config.email_from_address = email
	end

	def self.user_lifecycle_class
		Engine.config.user_lifecycle_class || ::User::Lifecycle
	end

	def self.user_lifecycle_class=(klass)
		Engine.config.user_lifecycle_class = klass
	end
end
