module Pbw
  class Rule
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :name, type: String
    validates :name, presence: true, uniqueness: true

    attr_accessible :name
  end
end
