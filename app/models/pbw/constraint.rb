module Pbw
  class Constraint < Rule
    has_and_belongs_to_many :tokens
    has_and_belongs_to_many :areas
  end
end
