module Pbw
	class AreaConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, foreign_key: 'area_id', class_name: "::Pbw::Area"
    	belongs_to :constraint, foreign_key: 'constraint_id', class_name: "::Pbw::Constraint"
	end
end