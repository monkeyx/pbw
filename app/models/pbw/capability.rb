module Pbw
  class Capability < Rule
    has_and_belongs_to_many :tokens
  end
end
