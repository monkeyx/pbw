module Pbw
  class Area < Container
    
    def self.viewable_by?(user, subject)
        true
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
  end
end
