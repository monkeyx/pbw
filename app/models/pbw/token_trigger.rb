module Pbw
	class TokenTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, class_name: '::Pbw::Token'
    	belongs_to :trigger, class_name: '::Pbw::Trigger'
	end
end