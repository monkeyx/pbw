require 'generators/pbw/scaffold_generator'

class Pbw::AreaGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path("../templates", __FILE__)

	protected
	def base_model_class
		"Pbw::Area"
	end

	def model_namespace
		"Areas"
	end
end
