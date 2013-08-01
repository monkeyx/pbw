module Pbw
  class AttachedProcess
    include ::Mongoid::Document
    include ::Mongoid::Timestamps
  	belongs_to :token, class_name: 'Pbw::Token'
  	belongs_to :area, class_name: 'Pbw::Area'
  	belongs_to :process, class_name: 'Pbw::Process'

  	field :tickable, type: Boolean, default: false
    field :updatable, type: Boolean, default: false
    field :ticks_waiting, type: Integer, default: 0
    field :updates_waiting, type: Integer, default: 0

    scope :tickable, where(tickable: true)
    scope :updatable, where(updatable: true)

    attr_accessible :token, :area, :process, :tickable, :updatable, :ticks_waiting, :updates_waiting

    def tick!
        return unless self.tickable && self.process && (self.token || self.area)
        unless self.ticks_waiting > 0
            self.process.run!(token_or_area)
            destroy
        else
            self.ticks_waiting = self.ticks_waiting - 1
            save!
        end
    end

    def update!
        return unless self.updatable && self.process && (self.token || self.area)
        unless self.updates_waiting > 0
            self.process.run!(token_or_area)
            destroy
        else
            self.updates_waiting = self.updates_waiting - 1
            save!
        end
    end

    def token_or_area
    	self.token || self.area
    end
  end
end