module Pbw
	class AreasController < BaseModelsController
		def set_model_class
			self.model_class = Area
		end
		def model_param
			'area'
		end
	end
end