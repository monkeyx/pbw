require 'generators/pbw/model_generator'

module Pbw
	module Generators
		class ScaffoldGenerator < ModelGenerator

			def append_router_file
				routes = []
				route_methods = []
				if available_views.include?('index')
					routes << "#{route_entry(plural_model_name,"index#{model_namespace}#{plural_name.camelize}")}" 
					route_methods << "#{route_method("index#{model_namespace}#{plural_name.camelize}", "Index")}"
				end
				if available_views.include?('new')
					routes << "#{route_entry("#{plural_model_name}/new","new#{model_namespace}#{class_name}")}" 
					route_methods << "#{route_method("new#{model_namespace}#{plural_name.camelize}", "New")}"
				end
				if available_views.include?('edit')
					routes << "#{route_entry("#{plural_model_name}/:id/edit","edit#{model_namespace}#{class_name}")}" 
					route_methods << "#{route_method("edit#{model_namespace}#{plural_name.camelize}", "Edit")}"
				end
				if available_views.include?('show')
					routes << "#{route_entry("#{plural_model_name}/:id","show#{model_namespace}#{class_name}")}" 
					route_methods << "#{route_method("show#{model_namespace}#{plural_name.camelize}", "Show")}"
				end
				if available_views.include?('index') # needs to be at the end
					routes << "#{route_entry("#{plural_model_name}/.*","index#{model_namespace}#{plural_name.camelize}")}" 
				end
				inject_into_file router_file, :after => 'initialize: (options) ->' do
					"\n    @#{plural_model_name} = new #{collection_namespace}Collection\n"
				end
				inject_into_file router_file, :after => 'routes:' do
					"\n#{routes.join('')}"
				end 
				inject_into_file router_file, :before => '  home: ->' do
					"#{route_methods.join("\n\n")}\n\n"
				end
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
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "class #{model_namespace}::#{class_name}", "class #{model_namespace}::#{class_name} < #{base_model_class}"
				gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "include Mongoid::Document", ""
			end

			protected
			def available_views
				%w(index show new edit)
			end

			def router_file
				File.join(backbone_path, "routers", "app_router.js.coffee")
			end

			def route_entry(path, method_name)
				"    \"#{path}\"\t:\t\"#{method_name}\"\n"
			end

			def route_method(method_name, view)
				method_params = case view
				when 'index', 'new'
					''
				when 'edit', 'show'
					"(id) "
				end
				view_js = case view
				when 'index'
					"@view = new #{view_namespace}.#{view}View(#{plural_model_name}: @#{plural_model_name})"
				when 'new'
					"#{singular_model_name} = new @#{plural_model_name}.model()\n        @view = new #{view_namespace}.#{view}View(#{plural_model_name}: @#{plural_model_name}, model: #{singular_model_name})"
				when 'edit', 'show'
					"#{singular_model_name} = new @#{plural_model_name}.get(id)\n        @view = new #{view_namespace}.#{view}View(#{plural_model_name}: @#{plural_model_name}, model: #{singular_model_name})"
				end
				"
  #{method_name}: #{method_params}->
    @#{plural_model_name}.fetch
      success: (collection) =>
        #{view_js}
        $(\"#app\").html(@view.render().el)
      error: (model, response) ->
        window.console && console.log response
"
		end
	end
end