module Pbw
  class Trigger < Rule
    has_and_belongs_to_many :tokens
    has_and_belongs_to_many :areas
    belongs_to :process

    def trigger?(token_or_area)
    	# stub method
    end

    def check!(token_or_area)
    	return false unless self.process && trigger?(token_or_area)
    	self.process.schedule!(token_or_area)
    end
  end
end
