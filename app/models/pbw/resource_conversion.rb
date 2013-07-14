module Pbw
  class ResourceConversion
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :resource
    field :to_class, :type => String
    field :conversion_rate, :type => Float
  end
end
