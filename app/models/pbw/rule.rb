module Pbw
  class Rule
    include ::Mongoid::Document
    field :name, type: String
    validates_presence_of :name
    validates_uniqueness_of :name

    attr_accessible :name
  end
end
