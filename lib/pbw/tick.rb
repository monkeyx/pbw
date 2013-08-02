module Pbw
	class Tick
		def self.run
			::Pbw::Command.tickable.each{|command| command.tick! }
			::Pbw::Container.each do |container|
				attached_processes.where(tickable: true).each{|ap| ap.tick! }
			end
		end
	end
end