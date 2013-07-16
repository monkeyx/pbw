module Pbw
	class TokensController < BaseModelsController
		def set_model_class
			self.model_class = Token
		end
	end
end