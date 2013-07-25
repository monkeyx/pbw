require 'generators/pbw/resource_helpers'

module Pbw
	module Generators
		class ModelGenerator < Rails::Generators::NamedBase
			include Pbw::Generators::ResourceHelpers

			argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

			def create_backbone_model
				template "model.coffee", "#{backbone_path}/models/#{model_namespace.downcase}/#{file_name}.js.coffee"
			end

			def create_model
				generate "model", "#{model_namespace}::#{class_name} #{attributes.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "class #{model_namespace}::#{class_name}", "class #{model_namespace}::#{class_name} < #{base_model_class}"
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "include Mongoid::Document", ""
			end
		end
	end
end