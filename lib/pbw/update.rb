module Pbw
	class Update
		def self.run
			Command.updatable.each{|command| command.update! }
			AttachedProcess.updatable.each{|ap| ap.update! }
		end
	end
end