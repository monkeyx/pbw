module Pbw
  class Trigger < Rule
    has_many :token_triggers, class_name: 'Pbw::TokenTrigger', foreign_key: 'Pbw/token_trigger_ids'
    has_many :area_triggers, class_name: 'Pbw::AreaTrigger', foreign_key: 'Pbw/area_trigger_ids'
    belongs_to :process, class_name: 'Pbw::Process'

    attr_accessible :process

    def self.viewable_by?(user, subject)
        return true if user.admin?
        subject.tokens.each do |token|
            return true if token.user && token.user == user
        end
        false
    end

    def self.creatable_by?(user, subject)
        user.admin?
    end

    def self.editable_by?(user, subject)
        user.admin?
    end

    def self.deletable_by?(user, subject)
        user.admin?
    end

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
