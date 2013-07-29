module Pbw
	class ItemsController < BaseModelsController
		def set_model_class
			self.model_class = Item
		end

		def model_param
			'item'
		end
	end
end