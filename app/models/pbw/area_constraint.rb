module Pbw
	class AreaConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :area, foreign_key: 'area_id'
    	belongs_to :constraint, foreign_key: 'constraint_id'
	end
end