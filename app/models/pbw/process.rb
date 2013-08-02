module Pbw
  class Process < Rule
    
    def before_run(container)
    	# stub method
    	true
    end

    def after_triggers(container)
    	# stub method
    end

    def changeset(container)
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

    def run!(container)
    	raise PbwArgumentError('Invalid token or area') unless container
        return false unless before_run(container)
    	changes = changeset(container)
    	raise PbwOperationError('No changes given') unless changes
    	raise PbwOperationError("Invalid object returned from changeset method in #{self.class.name}") unless changes.is_a?(Changeset)
    	return false token_or_area.check_constraints_and_capabilities(changes)
    	execute_changeset!(changes)
    	token_or_area.check_triggers!
    	after_triggers(container)
    end
  end
end
