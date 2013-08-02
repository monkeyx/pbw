module Pbw
	class Container
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	field :name, type: String
    	validates :name, presence: true

    	embeds_many :item_containers, class_name: "::Pbw::ItemContainer"
    	embeds_many :attached_processes, class_name: "::Pbw::AttachedProcess"
    	embeds_many :container_tokens, class_name: "::Pbw::ContainerToken"
    	embeds_many :container_constraints, class_name: "::Pbw::ContainerConstraint"
    	embeds_many :container_capabilities, class_name: "::Pbw::ContainerCapability"
    	embeds_many :container_triggers, class_name: "::Pbw::ContainerTrigger"

    	attr_accessible :name

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

	    def has_token?(token)
	    	raise PbwArgumentError("Invalid token") unless token
	    	self.container_tokens.where(token: token).first
	    end

	    def add_token!(token)
	    	raise PbwArgumentError("Invalid token") unless token
	    	return false if has_token?(token)
	    	self.container_tokens.create!(token: token)
	    	self
	    end

	    def remove_token!(token)
	    	raise PbwArgumentError("Invalid token") unless token
	    	ct = has_token?(token)
	    	return false unless ct
	    	ct.destroy
	    	self
	    end

	    def attach_tick_process(process, ticks_to_wait=0)
	        self.attached_processes.create!(process: process, tickable: true, ticks_waiting: ticks_to_wait)
	    end

	    def attach_update_process(process, updates_to_wait=0)
	        self.attached_processes.create!(process: process, updatable: true, updates_waiting: updates_to_wait)
	    end

	    def item_container(item)
	    	self.item_containers.where(item: item).first
	    end

	    def count_item(item)
	        container = item_container(item)
	        container ? container.quantity : 0
	    end

	    def add_item!(item, quantity)
	        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
	        return remove_item!(item, quantity.abs) if quantity < 0
	        raise PbwArgumentError('Invalid item') unless item
	        return false unless before_add_item(item,quantity)
	        container = item_container(item)
	    	container = self.item_containers.create!(item: item) unless container
	    	container.add_item(quantity_to_add)
	    end

	    def remove_item!(item, quantity)
	        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
	        return add_item!(item, quantity.abs) if quantity < 0
	        raise PbwArgumentError('Invalid item') unless item
	        container = item_container(item)
	        return false unless container
	        return false unless before_remove_item(item,quantity)
	        container.remove_item(quantity)
	    end

	    def constraints
	        self.container_constraints.map{|cc| cc.constraint }
	    end

	    def add_constraint!(constraint)
	        raise PbwArgumentError('Invalid constraint') unless constraint
	        return if self.container_constraints.any?{|cc| cc.constraint == constraint}
	        return false unless constraint.before_add(self)
	        self.container_constraints.create!(constraint: constraint)
	        constraint.after_add(self)
	        self
	    end

	    def delete_constraints!
	        self.container_constraints.destroy_all
	    end

	    def has_constraint?(constraint)
	        self.container_constraints.where(constraint: constraint).first
	    end

	    def remove_constraint!(constraint)
	        raise PbwArgumentError('Invalid constraint') unless constraint
	        return false unless constraint.before_remove(self)
	        cc = has_constraint?(constraint)
	        if cc
	            cc.destroy
	            constraint.after_remove(self)
	        end
	        self
	    end

	    def capabilities
	        self.container_capabilities.map{|cc| cc.capability }
	    end

	    def add_capability!(capability)
	        raise PbwArgumentError('Invalid capability') unless capability
	        return if self.container_capabilities.any?{|cc| cc.capability == capability}
	        return false unless capability.before_add(self)
	        self.container_capabilities.create!(capability: capability)
	        capability.after_add(self)
	        self
	    end

	    def delete_capabilities!
	        self.container_capabilities.destroy_all
	    end

	    def has_capability?(capability)
	        self.container_capabilities.where(capability: capability).first
	    end

	    def remove_capability!(capability)
	        raise PbwArgumentError('Invalid capability') unless capability
	        return false unless capability.before_remove(self)
	        cc = has_capability?(capability)
	        if cc
	            cc.destroy
	            capability.after_remove(self)
	        end
	        self
	    end

	    def triggers
	        self.container_triggers.map{|ct| cc.trigger }
	    end

	    def add_trigger!(trigger)
	        raise PbwArgumentError('Invalid trigger') unless trigger
	        return if self.container_triggers.any?{|ct| ct.trigger == trigger}
	        self.container_triggers.create!(trigger: trigger)
	        trigger.after_add(self)
	        self
	    end

	    def delete_trigger!
	        self.container_triggers.destroy_all
	    end

	    def has_trigger?(trigger)
	        self.container_triggers.where(trigger: trigger).first
	    end

	    def remove_trigger!(trigger)
	        raise PbwArgumentError('Invalid trigger') unless trigger
	        ct = has_trigger?(trigger)
	        if ct
	            ct.destroy
	        end
	        self
	    end

	    def check_triggers!
	        self.container_triggers.each{|ct| ct.trigger.check! }
	    end

	    def check_constraints_and_capabilities(&changeset)
	        self.container_constraints.any?{|cc| !cc.constraint.before_process(self, changeset)}
	        self.container_capabilities.any?{|cc| !cc.capability.before_process(self, changeset)}
	    end
	end
end