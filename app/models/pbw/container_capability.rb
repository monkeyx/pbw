module Pbw
	class ContainerCapability
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	embedded_in :container, class_name: "::Pbw::Container"
    	belongs_to :capability, foreign_key: 'capability_id', autosave: true, class_name: "::Pbw::Capability"
	end
end