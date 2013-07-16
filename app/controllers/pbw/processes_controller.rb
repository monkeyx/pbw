module Pbw
	class ProcessesController < BaseModelsController
		def set_model_class
			self.model_class = Process
		end
	end
end