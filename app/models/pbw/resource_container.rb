module Pbw
  class ResourceContainer
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
    belongs_to :resource
    field :quantity, :type => Float

    belongs_to :user_token
    belongs_to :area
    belongs_to :user
  end
end
