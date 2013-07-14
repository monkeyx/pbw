module Pbw
  class UserToken
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates_presence_of :name

    belongs_to :token
    belongs_to :user

    has_and_belongs_to_many :areas
    has_many :resource_containers
    
    attr_accessible :name
  end
end
