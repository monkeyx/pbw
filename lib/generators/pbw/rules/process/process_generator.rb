require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::ProcessGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path("../../../templates", __FILE__)
	def create_backbone_model
	end
  	protected
	def base_model_class
		"Pbw::Process"
	end

	def model_namespace
		"Processes"
	end

	def available_views
		[]
	end
end
