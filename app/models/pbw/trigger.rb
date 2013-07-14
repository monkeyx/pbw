module Pbw
  class Trigger < Rule
    has_and_belongs_to_many :tokens
    has_and_belongs_to_many :areas
    belongs_to :process
  end
end
