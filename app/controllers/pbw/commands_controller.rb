module Pbw
	class CommandsController < BaseModelsController
		def set_model_class
			self.model_class = Command
		end

		def update_model_before_create(model)
			model.user = current_user
		end

		def model_param
			'command'
		end
	end
end