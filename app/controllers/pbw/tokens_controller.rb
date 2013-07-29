module Pbw
	class TokensController < BaseModelsController
		def set_model_class
			self.model_class = Token
		end

		def update_model_before_create(model)
			model.user = current_user
		end

		def model_param
			'token'
		end
	end
end