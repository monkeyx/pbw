module Pbw
	class ResourcesController < BaseModelsController
		def set_model_class
			self.model_class = Resource
		end
	end
end