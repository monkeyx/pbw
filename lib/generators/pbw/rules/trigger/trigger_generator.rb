require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::TriggerGenerator < Pbw::Generators::ScaffoldGenerator
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
