require 'generators/pbw/resource_helpers'

module Pbw
	module Generators
		class ModelGenerator < Rails::Generators::NamedBase
			include Pbw::Generators::ResourceHelpers

			source_root File.expand_path("./templates", __FILE__)

			argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

			def create_backbone_model
				template "model.coffee", "#{backbone_path}/models/#{model_namespace.downcase}/#{file_name}.js.coffee"
			end
		end
	end
end