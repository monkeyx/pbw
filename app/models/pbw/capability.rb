module Pbw
  class Capability < Rule
    has_many :token_capabilities, foreign_key: 'token_capability_ids', autosave: true

    def self.viewable_by?(user, subject)
        return true if user.admin?
        subject.tokens.each do |token|
            return true if token.user && token.user == user
        end
        false
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
