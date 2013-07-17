require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::ConstraintGenerator < Pbw::Generators::ScaffoldGenerator
  	source_root File.expand_path('../templates', __FILE__)

  	protected
	def base_model_class
		"Pbw::Constraint"
	end
end
