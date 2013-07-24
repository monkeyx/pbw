module Pbw
  class Process < Rule
    has_many :triggers
    has_and_belongs_to_many :attached_processes
    
    def self.viewable_by?(user, subject)
        user.admin?
    end

    def self.creatable_by?(user, subject)
        true
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
    	Pbw::Changeset.new
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
  end
end
