module Pbw
	class TokenCapability
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, class_name: 'Pbw::Token'
    	belongs_to :capability, class_name: 'Pbw::Capability'
	end
end