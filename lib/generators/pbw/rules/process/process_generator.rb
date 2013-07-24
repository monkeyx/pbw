require 'generators/pbw/scaffold_generator'
require 'generators/pbw/rules/rules'

class Pbw::Rules::ProcessGenerator < Pbw::Generators::ScaffoldGenerator
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
