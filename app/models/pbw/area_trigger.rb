module Pbw
	class AreaTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, foreign_key: 'area_id', autosave: true, class_name: "::Pbw::Area"
    	belongs_to :trigger, foreign_key: 'trigger_id', autosave: true, class_name: "::Pbw::Trigger"
	end
end