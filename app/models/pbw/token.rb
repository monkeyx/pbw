module Pbw
  class Token
    include ::Mongoid::Document
    field :name, type: String
    validates_presence_of :name

    has_and_belongs_to_many :capabilities
    has_and_belongs_to_many :constraints
    has_and_belongs_to_many :processes
    has_and_belongs_to_many :triggers
    has_many :user_tokens

    attr_accessible :name
  end
end
