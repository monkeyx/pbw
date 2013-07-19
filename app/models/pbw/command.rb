module Pbw
  class Command < Rule
    has_and_belongs_to_many :processes
    belongs_to :token
    belongs_to :user

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
