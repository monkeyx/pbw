module Pbw
	class TokenConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, class_name: 'Pbw::Token'
    	belongs_to :constraint, class_name: 'Pbw::Constraint'
	end
end