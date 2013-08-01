module Pbw
	class AreaTrigger
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, class_name: 'Pbw::Area'
    	belongs_to :trigger, class_name: 'Pbw::Trigger'
	end
end