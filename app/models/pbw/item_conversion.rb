module Pbw
  class ItemConversion
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :from_classes, :type => Hash
  end
end
