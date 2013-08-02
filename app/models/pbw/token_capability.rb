module Pbw
	class TokenCapability
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true, class_name: "::Pbw::Token"
    	belongs_to :capability, foreign_key: 'capability_id', autosave: true, class_name: "::Pbw::Capability"
	end
end