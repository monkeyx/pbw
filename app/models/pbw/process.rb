module Pbw
  class Process < Rule
    has_and_belongs_to_many :tokens
    has_and_belongs_to_many :areas
    has_many :triggers
    
    field :run_tick, :type => Boolean
    field :run_update, :type => Boolean
  end
end
