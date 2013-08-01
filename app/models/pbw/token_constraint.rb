module Pbw
	class TokenConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	embedded_in :token, class_name: 'Pbw::Token'
    	belongs_to :constraint, class_name: 'Pbw::Constraint'
	end
end