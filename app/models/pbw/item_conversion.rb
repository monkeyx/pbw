module Pbw
  class ItemConversion
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :to_class, :type => String
    field :conversion_rate, :type => Float
  end
end
