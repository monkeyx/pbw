module Pbw
  class Process < Rule
    has_many :triggers
    
    field :run_tick, :type => Boolean
    field :run_update, :type => Boolean

    def self.viewable_by?(user, subject)
        user.admin?
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

    def before_run(token_or_area)
    	# stub method
    	true
    end

    def after_triggers(token_or_area)
    	# stub method
    end

    def changeset(token_or_area)
    	# stub method
    	raise "Not implemented"
    end

    def execute_changeset!(&changeset)
    	changeset.models_changed.each do |model|
    		changes = changeset.changes_for_model(model)
    		changes.keys.each do |field|
    			model.send("#{field}=".to_sym,changes[field])
    		end
    		return false unless model.save
    	end
    	true
    end

    def run!(token_or_area)
    	return false unless before_run(token_or_area)
    	changes = changeset(token_or_area)
    	return false unless changes
    	raise "Invalid object returned from changeset method in #{self.class.name}" unless changes.is_a?(Changeset)
    	return false unless token_or_area.check_constraints_and_capabilities(changes)
    	execute_changeset!(changes)
    	token_or_area.check_triggers!
    	after_triggers(token_or_area)
    end

    def schedule!(token_or_area)
    	# TODO
    	raise "Not implemented"
    end
  end
end
