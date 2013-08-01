module Pbw
  class Token
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates :name, presence: true

    belongs_to :area, class_name: '::Pbw::Area'
    belongs_to :user, class_name: '::Pbw::User'
    has_many :token_capabilities, class_name: '::Pbw::TokenCapability'
    has_many :token_constraints, class_name: '::Pbw::TokenConstraint'
    has_many :token_triggers, class_name: '::Pbw::TokenTrigger'
    has_many :attached_processes, class_name: '::Pbw::AttachedProcess'
    has_many :item_containers, class_name: '::Pbw::ItemContainer'

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
        AttachedProcess.create!(token: self, process: process, tickable: true, ticks_waiting: ticks_to_wait)
    end

    def attach_update_process(process, updates_to_wait=0)
        AttachedProcess.create!(token: self, process: process, updatable: true, updates_waiting: updates_to_wait)
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

    def constraints
        self.token_constraints.map{|tc| tc.constraint }
    end

    def constraints=(list)
        list.each{|c| Pbw::TokenConstraint.create!(token: self, constraint: c) }
        save!
    end

    def delete_constraints!
        self.token_constraints.each{|tc| tc.destroy }
    end

    def has_constraint?(constraint)
        constraint = Constraint.find(constraint) if constraint && constraint.is_a?(String)
        constraint && self.constraints.include?(constraint)
    end

    def add_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint 
        return if self.token_constraints.any?{|tc| tc.constraint == constraint}
        return false unless constraint.before_add(self)
        Pbw::TokenConstraint.create!(token: self, constraint: constraint)
        constraint.after_add(self)
        save!
        self
    end

    def remove_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint 
        return false unless constraint.before_remove(self)
        tc = TokenConstraint.where(token: token, constraint: constraint).first
        if tc
            tc.destroy
            save!
            constraint.after_remove(self)
        end
        self
    end

    def capabilities
        self.token_capabilities.map{|tc| tc.capability }
    end

    def capabilities=(list)
        list.each{|c| Pbw::TokenCapability.create!(token: self, capability: c) }
        save!
    end

    def delete_capabilities!
        self.token_capabilities.each{|tc| tc.destroy }
    end

    def has_capability?(capability)
        capability = Capability.find(capability) if capability && capability.is_a?(String)
        capability && self.capabilities.include?(capability)
    end

    def add_capability!(capability)
        raise PbwArgumentError('Invalid capability') unless capability
        return false unless capability && capability.before_add(self)
        return if self.token_capabilities.any?{|tc| tc.capability == capability}
        Pbw::TokenCapability.create!(token: self, capability: capability)
        save!
        capability.after_add(self)
        self
    end

    def remove_capability!(capability)
        raise PbwArgumentError('Invalid constraint') unless capability 
        return false unless capability.before_remove(self)
        tc = TokenCapability.where(token: token, capability: capability).first
        if tc
            tc.destroy
            save!
            capability.after_remove(self)
        end
        self
    end

    def check_constraints_and_capabilities(&changeset)
        self.capabilities.any?{|c| !c.before_process(self, changeset)}
        self.constraints.any?{|c| !c.before_process(self, changeset)}
    end

    def triggers
        self.token_triggers.map{|tt| tt.trigger }
    end

    def triggers=(list)
        list.each{|t| Pbw::TokenTrigger.create!(token: self, trigger: t) }
        save!
    end

    def delete_triggers!
        self.token_triggers.each{|tt| tt.destroy }
    end

    def has_trigger?(trigger)
        trigger = Trigger.find(trigger) if trigger && trigger.is_a?(String)
        trigger && self.triggers.include?(trigger)
    end

    def add_trigger!(trigger)
        raise PbwArgumentError('Invalid trigger') unless trigger
        return if self.token_triggers.any?{|tt| tt.trigger == trigger}
        Pbw::TokenTrigger.create!(token: self, trigger: trigger)
        self
    end

    def remove_trigger!(trigger)
        raise PbwArgumentError('Invalid trigger') unless trigger
        tt = TokenTrigger.where(token: token, trigger: trigger).first
        if tt
            tt.destroy 
            save!
        end
        self
    end

    def check_triggers!
        self.triggers.each{|t| t.check! }
    end
  end
end
