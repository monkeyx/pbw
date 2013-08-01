module Pbw
  class Constraint < Rule
    has_many :token_constraints, class_name: 'Pbw::TokenConstraint', foreign_key: 'Pbw/token_constraint_ids'
    has_many :area_constraints, class_name: 'Pbw::AreaConstraint', foreign_key: 'Pbw/area_constraint_ids'

    def tokens
        self.token_constraints.map{|tc| tc.token }
    end

    def tokens=(list)
        self.token_constraints = list.map{|t| Pbw::TokenConstraint.create(token: t, constraint: self) }
    end

    def tokens<<(t)
        return if self.token_constraints.any?{|tc| tc.token == t}
        self.token_constraints << Pbw::TokenConstraint.create(token: t, constraint: self)
    end

    def areas
        self.area_constraints.map{|tc| tc.area }
    end

    def areas=(list)
        self.area_constraints = list.map{|a| Pbw::AreaConstraint.create(area: a, constraint: self) }
    end

    def areas<<(a)
        return if self.area_constraints.any?{|ac| ac.area == a}
        self.area_constraints << Pbw::AreaConstraint.create(area: a, constraint: self)
    end

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
