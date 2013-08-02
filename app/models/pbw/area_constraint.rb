module Pbw
	class AreaConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :pbw_area
    	belongs_to :pbw_constraint
	end
end