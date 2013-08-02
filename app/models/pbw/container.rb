module Pbw
	class Container
		include ::Mongoid::Document
    	include ::Mongoid::Timestamps

    	field :name, type: String
    	validates :name, presence: true

    	embeds_many :item_containers, class_name: '::Pbw::ItemContainer'
    	embeds_many :attached_processes, class_name: '::Pbw::AttachedProcess'
    	embeds_many :tokens, class_name: '::Pbw::Token'
    	embeds_many :constraints, class_name: '::Pbw::Constraint'
    	embeds_many :capabilities, class_name: '::Pbw::Capability'
    	embeds_many :triggers, class_name: '::Pbw::Trigger'

    	attr_accessible :name

    	# STUB METHODS

    	def before_token_enters(token)
	        # stub method
	        true
	    end

	    def after_token_enters(token)
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

	    # ATTACHED PROCESSES

	    def attach_tick_process(process, ticks_to_wait=0)
	        self.attached_processes << AttachedProcess.build(process: process, tickable: true, ticks_waiting: ticks_to_wait)
	        save!
	    end

	    def attach_update_process(process, updates_to_wait=0)
	        self.attached_processes << AttachedProces.build(process: process, updatable: true, updates_waiting: updates_to_wait)
	        save!
	    end

	    # ITEM CONTAINERS

	    def item_container(item)
	    	self.item_containers.where(item: item).first
	    end

	    def count_item(item)
	        container = item_container(item)
	        container ? container.quantity : 0
	    end

	    def add_item!(item, quantity)
	        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
	        raise PbwArgumentError('Invalid item') unless item
	        return remove_item!(item, quantity.abs) if quantity < 0
	        return false unless before_add_item(item,quantity)
	        container = item_container(item)
	        unless container
	        	container = ItemContainer.build(item: item, quantity: 0)
	        	self.item_containers << container
	        	save!
	    	end
	    	container.add_item(quantity_to_add)
	    end

	    def remove_item!(item, quantity)
	        raise PbwArgumentError('Invalid quantity') unless quantity && quantity.responds_to?(:abs)
	        raise PbwArgumentError('Invalid item') unless item
	        return add_item!(item, quantity.abs) if quantity < 0
	        container = item_container(item)
	        return false unless container
	        return false unless before_remove_item(item,quantity)
	        container.remove_item(quantity)
	    end

	    # TOKENS

	    def has_token?(token)
	    	token && token._id && self.tokens.where(_id: token._id).first
	    end

	    def add_token!(token)
	    	raise PbwArgumentError('Invalid token') unless token
	    	return false if has_token?(token)
	    	self.tokens << token
	    	save!
	    	self
	    end

	    def remove_token!(token)
	    	ct = has_token?(token)
	    	return false unless ct
	    	ct.destroy
	    	self
	    end

	    # CONSTRAINTS

	    def add_constraint!(constraint)
	        raise PbwArgumentError('Invalid constraint') unless constraint
	        return false if has_constraint?(constraint)
	        return false unless constraint.before_add(self)
	        self.constraints << constraint
	        save!
	        constraint.after_add(self)
	        self
	    end

	    def has_constraint?(constraint)
	        constraint && constraint._id && self.constraints.where(_id: constraint._id).first
	    end

	    def remove_constraint!(constraint)
	        cc = has_constraint?(constraint)
	        return false unless cc && cc.before_remove(self)
	        if cc
	            cc.destroy
	            constraint.after_remove(self)
	        end
	        self
	    end

	    # CAPABILITIES

	    def add_capability!(capability)
	        raise PbwArgumentError('Invalid capability') unless capability
	        return false if has_capability?(capability)
	        return false unless capability.before_add(self)
	        self.capabilities << capability
	        save!
	        capability.after_add(self)
	        self
	    end

	    def has_capability?(capability)
	        capability && capability._id && self.container_capabilities.where(_id: capability._id).first
	    end

	    def remove_capability!(capability)
	        cc = has_capability?(capability)
	        return false unless cc && cc.before_remove(self)
	        if cc
	            cc.destroy
	            capability.after_remove(self)
	        end
	        self
	    end

	    # TRIGGERS

	    def add_trigger!(trigger)
	        raise PbwArgumentError('Invalid trigger') unless trigger
	        return false if has_trigger?(trigger)
	        self.triggers << trigger
	        save!
	        trigger.after_add(self)
	        self
	    end

	    def has_trigger?(trigger)
	        trigger && trigger._id && self.triggers.where(_id: trigger._id).first
	    end

	    def remove_trigger!(trigger)
	        ct = has_trigger?(trigger)
	        if ct
	            ct.destroy
	        end
	        self
	    end

	    def check_triggers!
	        self.triggers.each{|ct| ct.trigger.check! }
	    end

	    def check_constraints_and_capabilities(&changeset)
	        self.constraints.any?{|cc| !cc.before_process(self, changeset)}
	        self.constraints.any?{|cc| !cc.before_process(self, changeset)}
	    end
	end
end