require 'generators/pbw/resource_helpers'
require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CommandGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path("../../../templates", __FILE__)
	class_option :create_process, :type => :boolean, :aliases => "-P", :default => false,
                              :desc => "Create process for command"
	def create_process
		if options[:create_process]
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

	def default_attributes
		super
		@default_attributes << {name: 'token', default_value: ''}
		@default_attributes
	end
end
