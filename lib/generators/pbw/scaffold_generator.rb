require 'generators/pbw/model_generator'

module Pbw
	module Generators
		class ScaffoldGenerator < ModelGenerator

			def create_router_files 
				template 'router.coffee', File.join(backbone_path, "routers/#{model_namespace.downcase}", class_path, "#{plural_name}_router.js.coffee")
			end

			def create_view_files
				available_views.each do |view|
					template "views/#{view}_view.coffee", File.join(backbone_path, "views/#{model_namespace.downcase}", plural_name, "#{view}_view.js.coffee")
					template "templates/#{view}.jst", File.join(backbone_path, "templates/#{model_namespace.downcase}", plural_name, "#{view}.jst.ejs")  
				end
				template "views/model_view.coffee", File.join(backbone_path, "views/#{model_namespace.downcase}", plural_name, "#{singular_name}_view.js.coffee")
				template "templates/model.jst", File.join(backbone_path, "templates/#{model_namespace.downcase}", plural_name, "#{singular_name}.jst.ejs") 
			end

			def create_resources
				generate "model", "#{model_namespace}::#{class_name} #{attributes.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
				template "index.erb", "app/views/#{plural_name}/index.html.erb"
				generate "controller", "#{plural_name} index --skip"
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "class #{model_namespace}::#{class_name}", "class #{model_namespace}::#{class_name} < #{base_model_class}"
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "include Mongoid::Document", ""
			end

			protected
			def available_views
				%w(index show new edit)
			end
		end
	end
end