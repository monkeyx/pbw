module Pbw
	class AreaTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, foreign_key: 'area_id', autosave: true
    	belongs_to :trigger, foreign_key: 'trigger_id', autosave: true
	end
end