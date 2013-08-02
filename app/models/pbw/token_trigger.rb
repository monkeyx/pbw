module Pbw
	class TokenTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true, class_name: "::Pbw::Token"
    	belongs_to :trigger, foreign_key: 'trigger_id', autosave: true, class_name: "::Pbw::Trigger"
	end
end