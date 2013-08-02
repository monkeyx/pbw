module Pbw
	class TokenTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true
    	belongs_to :trigger, foreign_key: 'trigger_id', autosave: true
	end
end