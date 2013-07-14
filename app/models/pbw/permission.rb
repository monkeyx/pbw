module Pbw
  class Permission
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    field :subject_class, type: String
    field :action, type: String
    field :name, type: String

    attr_accessible :subject_class, :action, :name

    has_and_belongs_to_many :roles
  end
end
