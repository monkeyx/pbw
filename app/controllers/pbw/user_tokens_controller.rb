module Pbw
	class UserTokensController < BaseModelsController
		def set_model_class
			self.model_class = UserToken
		end
	end
end