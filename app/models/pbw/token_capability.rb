module Pbw
	class TokenCapability
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', auto_save: true
    	belongs_to :capability, foreign_key: 'capability_id', auto_save: true
	end
end