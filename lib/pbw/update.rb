module Pbw
	class Update
		def self.run
			::Pbw::Command.updatable.each{|command| command.update! }
			::Pbw::Container.each do |container|
				container.attached_processes.where(updatable: true).each{|ap| ap.update! }
			end
		end
	end
end