require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::CapabilityGenerator < Pbw::Generators::ScaffoldGenerator
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
