module Pbw
  class ItemContainer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :quantity, :type => Float

    belongs_to :tokens
    belongs_to :area
    belongs_to :user
  end
end
