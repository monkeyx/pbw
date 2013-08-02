module Pbw
	class ContainerToken
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	embedded_in :container, class_name: "::Pbw::Container"
    	belongs_to :token, foreign_key: 'token_id', autosave: true, class_name: "::Pbw::Token"
	end
end