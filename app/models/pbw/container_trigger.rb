module Pbw
	class ContainerTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	embedded_in :container, class_name: "::Pbw::Container"
    	belongs_to :trigger, foreign_key: 'trigger_id', autosave: true, class_name: "::Pbw::Trigger"
	end
end