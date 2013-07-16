module Pbw
  class Token
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name

    belongs_to :area
    has_and_belongs_to_many :capabilities
    has_and_belongs_to_many :constraints
    has_and_belongs_to_many :commands
    has_and_belongs_to_many :triggers
    has_and_belongs_to_many :users
    has_many :item_containers

    attr_accessible :name
  end
end
