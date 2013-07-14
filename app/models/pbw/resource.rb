module Pbw
  class Resource
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :resource_containers
    has_many :resource_transfers
    has_many :resource_conversions
    
    attr_accessible :name
  end
end
