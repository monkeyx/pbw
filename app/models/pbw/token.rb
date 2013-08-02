module Pbw
  class Token < Container
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    
    belongs_to :area, foreign_key: 'area_id', autosave: true, class_name: "::Pbw::Area"
    belongs_to :user, foreign_key: 'user_id', autosave: true, class_name: "::Pbw::User"
    
    attr_accessible :area, :user

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
        self.user = user
        save!
        after_ownership(user)
        self.user
    end

    def move_to_area!(area)
        raise PbwArgumentError('Invalid area') unless area
        return false unless before_move(area) && (self.area.nil? || self.area.before_token_leaves(self)) && area.before_token_enters(self)
        old_area = self.area
        self.area = area
        save!
        after_move(area)
        old_area.after_token_leaves(self) if old_area
        area.after_token_enters(self)
        self.area
    end
  end
end
