require 'generators/pbw/resource_helpers'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CommandGenerator < Rails::Generators::NamedBase
	include Pbw::Generators::ResourceHelpers
	source_root File.expand_path('../templates', __FILE__)

	argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

	def create_command
		template "command.rb", "app/models/commands/#{file_name}.rb"
	end

	def create_backbone_model
		template "model.coffee", "#{backbone_path}/models/#{file_name}.js.coffee"
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
		%w(index show new edit)
	end
end
