module Pbw
	class CommandsController < BaseModelsController
		def set_model_class
			self.model_class = Command
		end
	end
end