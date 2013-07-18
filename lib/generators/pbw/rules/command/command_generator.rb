require 'generators/pbw/resource_helpers'
require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CommandGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path('../templates', __FILE__)

	def create_resources
		generate "model", "Commands::#{class_name} #{attributes.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
		gsub_file "app/models/commands/#{file_name}.rb", "class #{class_name}", "class #{class_name} < #{base_model_class}"
		gsub_file "app/models/commands/#{file_name}.rb", "include Mongoid::Document", ""
	end

	def create_view_files
		available_views.each do |view|
			template "views/#{view}_view.coffee", File.join(backbone_path, "views", plural_name, "#{view}_view.js.coffee")
			template "templates/#{view}.jst", File.join(backbone_path, "templates", plural_name, "#{view}.jst.ejs")  
		end
		template "views/model_view.coffee", File.join(backbone_path, "views", plural_name, "#{singular_name}_view.js.coffee")
		template "templates/model.jst", File.join(backbone_path, "templates", plural_name, "#{singular_name}.jst.ejs") 
	end

	protected
	def available_views
		%w(new)
	end

	def base_model_class
		"Pbw::Command"
	end
end
