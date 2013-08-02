module Pbw
	class AreaTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, foreign_key: 'area_id', auto_save: true
    	belongs_to :trigger, foreign_key: 'trigger_id', auto_save: true
	end
end