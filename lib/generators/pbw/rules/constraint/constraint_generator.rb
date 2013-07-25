require 'generators/pbw/model_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::ConstraintGenerator < Pbw::Generators::ModelGenerator
	source_root File.expand_path("../../../templates", __FILE__)
	def create_backbone_model
	end
  	protected
	def base_model_class
		"Pbw::Constraint"
	end

	def model_namespace
		"Constraints"
	end

	def available_views
		[]
	end
end
