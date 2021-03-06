module Pbw
  class Trigger < Rule
    embedded_in :container, class_name: '::Pbw::Container'
    belongs_to :process, foreign_key: 'process_id', class_name: '::Pbw::Process'

    attr_accessible :process

    def trigger?(token_or_area)
    	# stub method
    end

    def check!(token_or_area)
        raise PbwArgumentErrror('Invalid token or area') unless token_or_area
    	return false unless self.process && trigger?(token_or_area)
    	self.process.schedule!(token_or_area)
    end
  end
end
