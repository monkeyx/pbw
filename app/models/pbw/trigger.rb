module Pbw
  class Trigger < Rule
    has_and_belongs_to_many :tokens, :class_name => 'Pbw::Token'
    has_and_belongs_to_many :areas, :class_name => 'Pbw::Area'
    belongs_to :process, :class_name => 'Pbw::Process'

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
    	return false unless self.process && trigger?(token_or_area)
    	self.process.schedule!(token_or_area)
    end
  end
end
