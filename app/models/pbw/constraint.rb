module Pbw
  class Constraint < Rule
    has_many :token_constraints, foreign_key: 'token_constraint_ids', autosave: true, class_name: "::Pbw::TokenConstraint"
    has_many :area_constraints, foreign_key: 'area_constraint_ids', autosave: true, class_name: "::Pbw::AreaConstraint"

    def self.viewable_by?(user, subject)
        return true if user.admin?
        subject.tokens.each do |token|
            return true if token.user && token.user == user
        end
        false
    end

    def self.creatable_by?(user, subject)
        user.admin?
    end

    def self.editable_by?(user, subject)
        user.admin?
    end

    def self.deletable_by?(user, subject)
        user.admin?
    end

    def before_process(token_or_area, &changeset)
    	# stub method
    	true
    end

    def before_add(token_or_area)
    	# stub method
    	true
    end

    def after_add(token_or_area)
    	# stub method
    end

    def before_remove(token_or_area)
    	# stub method
    	true
    end

    def after_remove(token_or_area)
    	# stub method
    end
  end
end
