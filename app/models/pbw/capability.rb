module Pbw
  class Capability < Rule
    has_many :token_capabilities, class_name: 'Pbw::TokenCapability', foreign_key: 'Pbw/token_capability_ids'

    def tokens
        self.token_capabilities.map{|tc| tc.token }
    end

    def tokens=(list)
        self.token_capabilities = list.map{|t| Pbw::TokenCapability.create(token: t, capability: self) }
    end

    def tokens<<(t)
        return if self.token_capabilities.any?{|tc| tc.token == t}
        self.token_capabilities << Pbw::TokenCapability.create(token: t, capability: self)
    end

    def delete_tokens!
        self.token_capabilities.each{|tc| tc.destroy }
    end

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
