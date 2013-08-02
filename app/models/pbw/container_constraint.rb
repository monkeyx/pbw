module Pbw
	class ContainerConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	embedded_in :container, class_name: "::Pbw::Container"
    	belongs_to :constraint, foreign_key: 'constraint_id', class_name: "::Pbw::Constraint"
	end
end