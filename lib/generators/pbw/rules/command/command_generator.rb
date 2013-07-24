require 'generators/pbw/resource_helpers'
require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CommandGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path('../templates', __FILE__)

	def create_resources
		attrs = attributes.select{|attr| attr.name != 'process'}
		generate "model", "Commands::#{class_name} #{attrs.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
		gsub_file "app/models/commands/#{file_name}.rb", "class Commands::#{class_name}", "class Commands::#{class_name} < #{base_model_class}"
		gsub_file "app/models/commands/#{file_name}.rb", "include Mongoid::Document", ""
	end

	def create_view_files
		available_views.each do |view|
			template "views/#{view}_view.coffee", File.join(backbone_path, "views/commands", plural_name, "#{view}_view.js.coffee")
			template "templates/#{view}.jst", File.join(backbone_path, "templates/commands", plural_name, "#{view}.jst.ejs")  
		end
		template "views/model_view.coffee", File.join(backbone_path, "views/commands", plural_name, "#{singular_name}_view.js.coffee")
		template "templates/model.jst", File.join(backbone_path, "templates/commands", plural_name, "#{singular_name}.jst.ejs") 
	end

	def create_process
		if attributes.any?{|attr| attr.name == 'process'}
			attrs = attributes.select{|attr| attr.name != 'process'}
			generate "pbw:rules:process", "#{class_name} #{attrs.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
		end
	end

	protected
	def available_views
		%w(new)
	end

	def base_model_class
		"Pbw::Command"
	end
end
