module Pbw
  class Command < Rule
    belongs_to :token, class_name: '::Pbw::Token'
    belongs_to :user, class_name: '::Pbw::User'

    before_validation :validate_token_and_user
    
    field :tickable, type: Boolean, default: false
    field :updatable, type: Boolean, default: false
    field :ticks_waiting, type: Integer, default: 0
    field :updates_waiting, type: Integer, default: 0

    before_save :set_tickable_and_updatable    

    scope :tickable, where(tickable: true)
    scope :updatable, where(updatable: true)

    attr_accessible :token, :user, :tickable, :updatable, :ticks_waiting, :updates_waiting

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

    def runs_on_ticks?
        # stub method
        false
    end

    def runs_on_updates?
        # stub method
        false
    end

    def processes
        # stub method
        []
    end

    def set_tickable_and_updatable
        self.tickable = runs_on_ticks?
        self.updatable = runs_on_updates?
    end

    def run_processes!
        procs = processes
        raise PbwOperationError('Invalid processes') if procs.nil?
        if procs.responds_to?(:each)
            procs.each do |process|
                process.run!(self.token)
            end
        elsif procs.ancestors.include?(Process)
            process.run!(self.token)
        else
            raise PbwOperationError("Invalid return method from #{self.class.name}.processes")
        end
    end

    def validate_token_and_user
        errors.add(:token, 'Invalid token') unless valid_for_token?(self.token)
        errors.add(:user, 'Invalid user') unless valid_for_user?(self.user)
    end

    def tick!
        return unless self.tickable
        unless self.ticks_waiting > 0
            run_processes!
            destroy
        else
            self.ticks_waiting = self.ticks_waiting - 1
            save!
        end
    end

    def update!
        return unless self.updatable
        unless self.updates_waiting > 0
            run_processes!
            destroy
        else
            self.updates_waiting = self.updates_waiting - 1
            save!
        end
    end
  end
end
