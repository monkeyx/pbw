module Pbw
  class ItemContainer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :item
    field :quantity, :type => Float

    belongs_to :user_token
    belongs_to :area
    belongs_to :user
  end
end
