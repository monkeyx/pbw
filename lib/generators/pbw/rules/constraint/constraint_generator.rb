require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::ConstraintGenerator < Pbw::Generators::ScaffoldGenerator
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
