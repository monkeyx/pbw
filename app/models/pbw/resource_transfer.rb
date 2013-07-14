module Pbw
  class ResourceTransfer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :resource
    field :from_class, :type => String
    field :to_class, :type => String
  end
end
