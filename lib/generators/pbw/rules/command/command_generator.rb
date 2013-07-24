require 'generators/pbw/resource_helpers'
require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CommandGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path('../templates', __FILE__)

	def create_resources
		attrs = attributes.select{|attr| attr.name != 'process'}
		generate "model", "#{model_namespace}::#{class_name} #{attrs.map{|attr| "#{attr.name}:#{attr.type}"}.join(' ')}"
		gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "class #{model_namespace}::#{class_name}", "class #{model_namespace}::#{class_name} < #{base_model_class}"
		gsub_file "app/models/#{model_namespace.downcase}/#{file_name}.rb", "include Mongoid::Document", ""
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

	def model_namespace
		"Commands"
	end
end
