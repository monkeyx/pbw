module Pbw
  class ItemTransfer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :from_class, :type => String
    field :to_class, :type => String

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
