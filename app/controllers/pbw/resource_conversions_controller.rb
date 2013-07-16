module Pbw
	class ResourceConversionsController < BaseModelsController
		def set_model_class
			self.model_class = ResourceConversion
		end
	end
end