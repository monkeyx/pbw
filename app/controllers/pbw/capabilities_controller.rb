module Pbw
	class CapabilitiesController < BaseModelsController
		def set_model_class
			self.model_class = Capability
		end
	end
end