module Pbw
  class Token < Container
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    
    def self.viewable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def self.creatable_by?(user, subject)
        true
    end

    def self.editable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def self.deletable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def before_ownership(user)
        # stub method
        true
    end

    def after_ownership(user)
        # stub method
    end

    def before_move(area)
        # stub method
        true
    end

    def after_move(area)
        # stub method
    end

    def can_convert?(item)
        self.capabilities.any?{|c| c.can_convert?(item)}
    end

    def set_ownership!(user)
        raise PbwArgumentError('Invalid user') unless user 
        return false unless before_ownership(user)
        user.add_token!(self)
        after_ownership(user)
        self
    end

    def move_to_area!(area)
        raise PbwArgumentError('Invalid area') unless area
        return false unless before_move(area)
        area.add_token!(self)
        after_move(area)
        area.after_token_enters(self)
        self
    end
  end
end
