module Pbw
	class TokenCapability
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true
    	belongs_to :capability, foreign_key: 'capability_id', autosave: true
	end
end