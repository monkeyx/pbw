require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CapabilityGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path("../../../templates", __FILE__)
	def create_backbone_model
	end
  	protected
	def base_model_class
		"Pbw::Capability"
	end

	def model_namespace
		"Capabilities"
	end

	def available_views
		[]
	end
end
