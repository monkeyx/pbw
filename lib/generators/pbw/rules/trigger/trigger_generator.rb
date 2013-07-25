require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::TriggerGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path("../../../templates", __FILE__)
	def create_backbone_model
	end
  	protected
	def base_model_class
		"Pbw::Trigger"
	end

	def model_namespace
		"Triggers"
	end

	def available_views
		[]
	end
end
