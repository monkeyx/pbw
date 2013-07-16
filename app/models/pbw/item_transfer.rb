module Pbw
  class ItemTransfer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :from_class, :type => String
    field :to_class, :type => String
  end
end
