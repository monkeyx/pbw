module Pbw
	class ConstraintsController < BaseModelsController
		def set_model_class
			self.model_class = Constraint
		end
	end
end