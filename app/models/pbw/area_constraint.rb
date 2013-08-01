module Pbw
	class AreaConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, class_name: '::Pbw::Area'
    	belongs_to :constraint, class_name: '::Pbw::Constraint'
	end
end