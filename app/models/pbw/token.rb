module Pbw
  class Token
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name

    belongs_to :area
    has_and_belongs_to_many :capabilities
    has_and_belongs_to_many :constraints
    has_and_belongs_to_many :triggers
    has_and_belongs_to_many :users
    has_many :item_containers

    attr_accessible :name

    def before_ownership(user)
        # stub method
        true
    end

    def after_ownership(user)
        # stub method
    end

    def before_move(area)
        # stub method
        true
    end

    def after_move(area)
        # stub method
    end

    def add_constraint!(constraint)
        return false unless constraint && constraint.before_add(self)
        self.constraints << constraint
        save
        constraint.after_add(self)
        self
    end

    def remove_constraint!(constraint)
        return false unless constraint && constraint.before_remove(self)
        self.constraints.delete_if{|c| c.name == constraint.name}
        save
        constraint.after_remove(self)
        self
    end

    def add_capability!(capability)
        return false unless capability && capability.before_add(self)
        self.capabilities << capability
        save
        capability.after_add(self)
        self
    end

    def remove_capability!(capability)
        return false unless capability && capability.before_remove(self)
        self.capabilities.delete_if{|c| c.name == capability.name}
        save
        capability.after_remove(self)
        self
    end

    def check_constraints_and_capabilities(&changeset)
        self.capabilities.any?{|c| !c.before_process(self, changeset)}
        self.constraints.any?{|c| !c.before_process(self, changeset)}
    end

    def check_triggers!
        self.triggers.each{|t| t.check! }
    end
  end
end
