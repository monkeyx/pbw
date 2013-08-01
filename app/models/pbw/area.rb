module Pbw
  class Area
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    
    validates :name, presence: true

    has_many :tokens, class_name:'Pbw::Token', foreign_key: 'Pbw/token_ids'
    has_many :item_containers, class_name: 'Pbw::ItemContainer', foreign_key: 'Pbw/item_container_ids'
    has_many :attached_processes, class_name: 'Pbw::AttachedProcess', foreign_key: 'Pbw/attached_process_ids'
    has_many :area_constraints, class_name: 'Pbw::AreaConstraint', foreign_key: 'Pbw/area_constraint_ids'
    has_many :area_triggers, class_name: 'Pbw::AreaTrigger', foreign_key: 'Pbw/area_trigger_ids'
    
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
        AttachedProcess.create!(area: self, process: process, tickable: true, ticks_waiting: ticks_to_wait)
    end

    def attach_update_process(process, updates_to_wait=0)
        AttachedProcess.create!(area: self, process: process, updatable: true, updates_waiting: updates_to_wait)
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

    def constraints
        self.area_constraints.map{|ac| ac.constraint }
    end

    def constraints=(list)
        list.each{|c| Pbw::AreaConstraint.create!(area: self, constraint: c) }
        save!
    end

    def add_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint
        return if self.area_constraints.any?{|ac| ac.constraint == constraint}
        return false unless constraint.before_add(self)
        Pbw::AreaConstraint.create!(area: self, constraint: constraint)
        constraint.after_add(self)
        save!
        self
    end

    def delete_constraints!
        self.area_constraints.each{|ac| ac.destroy }
    end

    def has_constraint?(constraint)
        constraint = Constraint.find(constraint) if constraint && constraint.is_a?(String)
        constraint && self.constraints.include?(constraint)
    end

    def remove_constraint!(constraint)
        raise PbwArgumentError('Invalid constraint') unless constraint
        return false unless constraint.before_remove(self)
        ac = AreaConstraint.where(area: self, constraint: constraint).first
        if ac
            ac.destroy
            constraint.after_remove(self)
            save!
        end
        self
    end

    def check_constraints_and_capabilities(&changeset)
        self.constraints.any?{|c| !c.before_process(self, changeset)}
    end

    def triggers
        self.area_triggers.map{|at| at.trigger }
    end

    def triggers=(list)
        list.each{|t| Pbw::AreaTrigger.create!(area: self, trigger: t) }
        save!
    end

    def add_triggers!(trigger)
        raise PbwArgumentError('Invalid trigger') unless trigger
        return if self.area_triggers.any?{|at| at.trigger == trigger}
        Pbw::AreaTrigger.create!(area: self, trigger: trigger)
        save!
        self
    end

    def delete_triggers!
        self.area_triggers.each{|at| at.destroy }
    end

    def has_trigger?(trigger)
        trigger = Trigger.find(trigger) if trigger && trigger.is_a?(String)
        trigger && self.triggers.include?(trigger)
    end

    def remove_trigger!(trigger)
        raise PbwArgumentError('Invalid trigger') unless trigger
        at = AreaTrigger.where(area: self, trigger: trigger).first
        if at
            at.destroy 
            save!
        end
        self
    end

    def check_triggers!
        self.triggers.each{|t| t.check! }
    end
  end
end
