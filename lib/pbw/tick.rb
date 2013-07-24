module Pbw
	class Tick
		def self.run
			Command.tickable.each{|command| command.tick! }
			AttachedProcess.tickable.each{|ap| ap.tick! }
		end
	end
end