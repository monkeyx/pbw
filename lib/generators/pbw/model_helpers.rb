require 'generators/pbw/resource_helpers'

module Pbw
	module Generators
		module ModelHelpers
			include Pbw::Generators::ResourceHelpers

			def create_backbone_model
				template "model.coffee", "#{backbone_path}/models/#{file_name}.js.coffee"
			end
		end
	end
end