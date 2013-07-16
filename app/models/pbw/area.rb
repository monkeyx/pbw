module Pbw
  class Area
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name
    validates_uniqueness_of :name

    has_many :tokens
    has_many :item_containers
    has_and_belongs_to_many :constraints
    has_and_belongs_to_many :processes
    has_and_belongs_to_many :triggers

    attr_accessible :name
  end
end
