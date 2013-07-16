module Pbw
	class TriggersController < BaseModelsController
		def set_model_class
			self.model_class = Trigger
		end
	end
end