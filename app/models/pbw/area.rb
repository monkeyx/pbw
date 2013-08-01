module Pbw
  class Area
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    
    validates :name, presence: true

    has_many :tokens, :class_name => 'Pbw::Token'
    has_many :item_containers, :class_name => 'Pbw::ItemContainer'
    has_many :attached_processes, :class_name => 'Pbw::AttachedProcess'
    has_and_belongs_to_many :constraints, :class_name => 'Pbw::Constraint'
    has_and_belongs_to_many :triggers, :class_name => 'Pbw::Trigger'
    
    attr_accessible :name

    def self.viewable_by?(user, subject)
        true
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

    def before_token_enters(token)
        # stub method
        true
    end

    def after_token_enters(token)
        # stub method
    end

    def before_token_leaves(token)
        # stub method
        true
    end

    def after_token_leaves(token)
        # stub method
    end

    def before_add_item(item, quantity)
        # stub method
        true
    end

    def after_add_item(item, quantity)
        # stub method
    end

    def before_remove_item(item, quantity)
        # stub method
        true
    end

    def after_remove_item(item, quantity)
        # stub method
    end

    def attach_tick_process(process, ticks_to_wait=0)
        AttachedProcess.create(area: self, process: process, tickable: true, ticks_waiting: ticks_to_wait)
    end

    def attach_update_process(process, updates_to_wait=0)
        AttachedProcess.create(area: self, process: process, updatable: true, updates_waiting: updates_to_wait)
    end

    def count_item(item)
        container = ItemContainer.find_for_area(self)
        container ? container.quantity : 0
    end

    def add_item!(item, quantity)
        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
        return remove_item!(item, quantity.abs) if quantity < 0
        raise PbwArgumentError('Invalid item') unless item
        return false unless before_add_item(item,quantity)
        ItemContainer.find_or_create_for_area(self, item, quantity)
    end

    def remove_item!(item, quantity)
        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
        return add_item!(item, quantity.abs) if quantity < 0
        raise PbwArgumentError('Invalid item') unless item
        return false unless before_remove_item(item,quantity)
        ItemContainer.find_or_create_for_area(self, item, (0 - quantity))
    end

    def has_constraint?(constraint)
        constraint = Constraint.find(constraint) if constraint.is_a?(String)
        self.constraints.include?(constraint)
    end

    def add_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint
        return false unless constraint.before_add(self)
        self.constraints << constraint
        save!
        constraint.after_add(self)
        self
    end

    def remove_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint
        return false unless constraint.before_remove(self)
        self.constraints.delete_if{|c| c.name == constraint.name}
        save!
        constraint.after_remove(self)
        self
    end

    def check_constraints_and_capabilities(&changeset)
        self.constraints.any?{|c| !c.before_process(self, changeset)}
    end

    def check_triggers!
        self.triggers.each{|t| t.check! }
    end
  end
end
