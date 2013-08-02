module Pbw
  class Item
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String

    validates :name, presence: true

    has_many :item_containers, foreign_key: 'item_container_ids', autosave: true, class_name: "::Pbw::ItemContainer"
    has_many :item_conversions, foreign_key: 'item_conversion_ids', autosave: true, class_name: "::Pbw::ItemConversion"
    
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

    def before_add(container, quantity)
        # stub method
        true
    end

    def after_add(container, quantity)
        # stub method
    end

    def before_remove(container, quantity)
        # stub method
        true
    end

    def after_remove(container, quantity)
        # stub method
    end

    def before_transfer(from, to, quantity)
        # stub method
        true
    end

    def after_transfer(from, to, quantity)
        # stub method
    end

    def before_conversion(to, quantity)
        # stub method
        true
    end

    def after_conversion(to, quantity)
        # stub method
    end
  end
end
