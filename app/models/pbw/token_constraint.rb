module Pbw
	class TokenConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', autosave: true
    	belongs_to :constraint, foreign_key: 'constraint_id', autosave: true
	end
end