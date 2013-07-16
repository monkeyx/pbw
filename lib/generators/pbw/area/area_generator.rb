require 'generators/pbw/model_helpers'

class Pbw::AreaGenerator < Rails::Generators::NamedBase
	
	source_root File.expand_path("../templates", __FILE__)

	include Pbw::Generators::ScaffoldHelpers
end
