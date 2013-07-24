module Pbw
  class Rule
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates :name, presence: true, uniqueness: true

    attr_accessible :name

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
