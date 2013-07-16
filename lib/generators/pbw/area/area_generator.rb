require 'generators/pbw/scaffold_generator'

class Pbw::AreaGenerator < Pbw::Generators::ScaffoldGenerator
	source_root File.expand_path("../templates", __FILE__)
end
