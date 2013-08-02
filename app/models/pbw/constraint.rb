module Pbw
  class Constraint < Rule
    embedded_in :container, class_name: '::Pbw::Container'
    
    def before_process(token_or_area, &changeset)
    	# stub method
    	true
    end

    def before_add(token_or_area)
    	# stub method
    	true
    end

    def after_add(token_or_area)
    	# stub method
    end

    def before_remove(token_or_area)
    	# stub method
    	true
    end

    def after_remove(token_or_area)
    	# stub method
    end
  end
end
