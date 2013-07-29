require 'generators/pbw/scaffold_generator'

class Pbw::TokenGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path("../../templates", __FILE__)
  	protected
	def base_model_class
		"Pbw::Token"
	end

	def model_namespace
		"Tokens"
	end

	def param_root
		'token'
	end
end
