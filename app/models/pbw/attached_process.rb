module Pbw
  class AttachedProcess
    include ::Mongoid::Document
    include ::Mongoid::Timestamps

  	embedded_in :container, class_name: "::Pbw::Container"
  	belongs_to :process, foreign_key: 'process_id', autosave: true, class_name: "::Pbw::Process"

  	field :tickable, type: Boolean, default: false
    field :updatable, type: Boolean, default: false
    field :ticks_waiting, type: Integer, default: 0
    field :updates_waiting, type: Integer, default: 0

    scope :tickable, where(tickable: true)
    scope :updatable, where(updatable: true)

    attr_accessible :container, :process, :tickable, :updatable, :ticks_waiting, :updates_waiting

    def tick!
        return unless self.tickable && self.process && self.container
        unless self.ticks_waiting > 0
            self.process.run!(self.container)
            destroy
        else
            self.ticks_waiting = self.ticks_waiting - 1
            save!
        end
    end

    def update!
        return unless self.updatable && self.process && self.container
        unless self.updates_waiting > 0
            self.process.run!(self.container)
            destroy
        else
            self.updates_waiting = self.updates_waiting - 1
            save!
        end
    end
  end
end