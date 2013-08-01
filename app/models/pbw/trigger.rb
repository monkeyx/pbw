module Pbw
  class Trigger < Rule
    has_many :token_triggers, class_name: 'Pbw::TokenTrigger', foreign_key: 'Pbw/token_trigger_ids'
    has_many :area_triggers, class_name: 'Pbw::AreaTrigger', foreign_key: 'Pbw/area_trigger_ids'
    belongs_to :process, class_name: 'Pbw::Process'

    attr_accessible :process

    def tokens
        self.token_triggers.map{|tt| tt.token }
    end

    def tokens=(list)
        self.token_triggers = list.map{|t| Pbw::TokenTrigger.create(token: t, trigger: self) }
    end

    def tokens<<(t)
        return if self.token_triggers.any?{|tt| tt.token == t}
        self.token_triggers << Pbw::TokenTrigger.create(token: t, trigger: self)
    end

    def delete_tokens!
        self.token_triggers.each{|tt| tt.destroy }
    end

    def areas
        self.area_triggers.map{|at| at.area }
    end

    def areas=(list)
        self.area_triggers = list.map{|a| Pbw::AreaTrigger.create(area: t, trigger: self) }
    end

    def areas<<(a)
        return if self.area_triggers.any?{|at| at.area == a}
        self.area_triggers << Pbw::AreaTrigger.create(area: a, trigger: self)
    end

    def delete_areas!
        self.area_triggers.each{|at| at.destroy }
    end

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
