module Pbw
  class Process < Rule
    has_many :triggers, class_name: 'Pbw::Trigger', foreign_key: 'Pbw/trigger_ids'
    has_many :attached_processes, class_name: 'Pbw::AttachedProcess', foreign_key: 'Pbw/attached_process_ids'
    
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
                begin
    			 model.send("#{field}=".to_sym,changes[field])
                rescue Exception => e
                    raise PbwOperationError(e)
                end
    		end
    		model.save!
    	end
    	true
    end

    def run!(token_or_area)
    	raise PbwArgumentError('Invalid token or area') unless token_or_area
        return false unless before_run(token_or_area)
    	changes = changeset(token_or_area)
    	raise PbwOperationError('No changes given') unless changes
    	raise PbwOperationError("Invalid object returned from changeset method in #{self.class.name}") unless changes.is_a?(Changeset)
    	return false token_or_area.check_constraints_and_capabilities(changes)
    	execute_changeset!(changes)
    	token_or_area.check_triggers!
    	after_triggers(token_or_area)
    end
  end
end
