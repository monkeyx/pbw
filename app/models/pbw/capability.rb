module Pbw
  class Capability < Rule
    def before_process(token, &changeset)
    	# stub method
    	true
    end

    def before_add(token)
    	# stub method
    	true
    end

    def after_add(token)
    	# stub method
    end

    def before_remove(token)
    	# stub method
    	true
    end

    def after_remove(token)
    	# stub method
    end

    def can_convert?(item)
        # stub method
        false
    end
  end
end
