module Pbw
	class TokenConstraint
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	belongs_to :token, foreign_key: 'token_id', auto_save: true
    	belongs_to :constraint, foreign_key: 'constraint_id', auto_save: true
	end
end