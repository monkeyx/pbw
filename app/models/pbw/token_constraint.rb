module Pbw
	class TokenConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true, class_name: "::Pbw::Token"
    	belongs_to :constraint, foreign_key: 'constraint_id', autosave: true, class_name: "::Pbw::Constraint"
	end
end