require "pbw/engine"

module Pbw
	def self.email_from_address
		Engine.config.email_from_address
	end

	def self.email_from_address=(email)
		Engine.config.email_from_address = email
	end
end
