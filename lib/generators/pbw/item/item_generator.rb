require 'generators/pbw/scaffold_generator'

class Pbw::ItemGenerator < Pbw::Generators::ScaffoldGenerator
	protected
	def base_model_class
		"Pbw::Item"
	end

	def model_namespace
		"Items"
	end
end
