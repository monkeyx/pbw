module Pbw
  class Command < Rule
    has_and_belongs_to_many :processes
    belongs_to :token
    belongs_to :user

    def self.viewable_by?(user, subject)
        user.admin? || subject.user == user
    end

    def self.creatable_by?(user, subject)
        user.admin? || subject.user.nil? || (subject.user == user && subject.token.user && subject.token.user == user)
    end

    def self.editable_by?(user, subject)
        user.admin? || (subject.user == user && subject.token.user && subject.token.user == user)
    end

    def self.deletable_by?(user, subject)
        user.admin? || (subject.user == user && subject.token.user && subject.token.user == user)
    end

    def valid_for_token?(token)
        # stub method
        false
    end

    def valid_for_user?(user)
        # stub method
        false
    end

    def preprocess
        # stub method
    end

    def postprocess
        # stub method
    end
  end
end
