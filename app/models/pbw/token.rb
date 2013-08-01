module Pbw
  class Token
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates :name, presence: true

    belongs_to :area, class_name: 'Pbw::Area'
    belongs_to :user, class_name: 'Pbw::User'
    has_and_belongs_to_many :capabilities, class_name: 'Pbw::Capability', foreign_key: 'Pbw/capability_ids'
    has_and_belongs_to_many :constraints, class_name: 'Pbw::Constraint', foreign_key: 'Pbw/constraint_ids'
    has_and_belongs_to_many :triggers, class_name:'Pbw::Trigger', foreign_key: 'Pbw/trigger_ids'
    has_many :attached_processes, class_name: 'Pbw::AttachedProcess', foreign_key: 'Pbw/attached_process_ids'
    has_many :item_containers, class_name: 'Pbw::ItemContainer', foreign_key: 'Pbw/item_container_ids'

    attr_accessible :name, :area, :user

    def self.viewable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def self.creatable_by?(user, subject)
        true
    end

    def self.editable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def self.deletable_by?(user, subject)
        user.admin? || subject.user == user
    end

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
        AttachedProcess.create(token: self, process: process, tickable: true, ticks_waiting: ticks_to_wait)
    end

    def attach_update_process(process, updates_to_wait=0)
        AttachedProcess.create(token: self, process: process, updatable: true, updates_waiting: updates_to_wait)
    end

    def can_convert?(item)
        self.capabilities.any?{|c| c.can_convert?(item)}
    end

    def count_item(item)
        container = ItemContainer.find_for_token(self)
        container ? container.quantity : 0
    end

    def add_item!(item, quantity)
        raise PbwArgumentError('Invalid quantity')unless quantity && quantity.responds_to?(:abs)
        return remove_item!(item, quantity.abs) if quantity < 0
        raise PbwArgumentError('Invalid item') unless item 
        return false unless before_add_item(item,quantity)
        ItemContainer.find_or_create_for_token(self, item, quantity)
    end

    def remove_item!(item, quantity)
        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
        return add_item!(item, quantity.abs) if quantity < 0
        raise PbwArgumentError('Invalid item') unless item 
        return false unless before_remove_item(item,quantity)
        ItemContainer.find_or_create_for_token(self, item, (0 - quantity))
    end

    def set_ownership!(user)
        raise PbwArgumentError('Invalid user') unless user 
        return false unless before_ownership(user)
        self.user = user
        save!
        after_ownership(user)
        self.user
    end

    def move_to_area!(area)
        raise PbwArgumentError('Invalid area') unless area
        return false unless before_move(area) && (self.area.nil? || self.area.before_token_leaves(self)) && area.before_token_enters(self)
        old_area = self.area
        self.area = area
        save!
        after_move(area)
        old_area.after_token_leaves(self) if old_area
        area.after_token_enters(self)
        self.area
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

    def has_capability?(capability)
        capability = Capability.find(capability) if capability.is_a?(String)
        self.capabilities.include?(capability)
    end

    def add_capability!(capability)
        return false unless capability && capability.before_add(self)
        self.capabilities << capability
        save!
        capability.after_add(self)
        self
    end

    def remove_capability!(capability)
        raise PbwArgumentError('Invalid constraint') unless capability 
        return false unless capability.before_remove(self)
        self.capabilities.delete_if{|c| c.name == capability.name}
        save!
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
