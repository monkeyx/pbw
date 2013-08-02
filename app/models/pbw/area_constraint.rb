module Pbw
	class AreaConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area
    	belongs_to :constraint
	end
end