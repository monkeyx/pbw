module Pbw
  class Constraint < Rule
    has_and_belongs_to_many :tokens
    has_and_belongs_to_many :areas

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
