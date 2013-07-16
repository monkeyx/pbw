module Pbw
	class ResourceContainersController < BaseModelsController
		def set_model_class
			self.model_class = ResourceContainer
		end
	end
end