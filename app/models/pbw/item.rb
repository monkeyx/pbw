module Pbw
  class Item
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :item_containers
    has_many :item_transfers
    has_many :item_conversions
    
    attr_accessible :name
  end
end
