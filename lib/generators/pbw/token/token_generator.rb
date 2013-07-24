require 'generators/pbw/scaffold_generator'

class Pbw::TokenGenerator < Pbw::Generators::ScaffoldGenerator
  protected
	def base_model_class
		"Pbw::Token"
	end

	def model_namespace
		"Tokens"
	end
end
