require 'generators/pbw/scaffold_generator'

class Pbw::ItemGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path("../templates", __FILE__)

	protected
	def base_model_class
		"Pbw::Item"
	end
end
