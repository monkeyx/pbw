require 'generators/pbw/model_helpers'

class Pbw::AreaGenerator < Rails::Generators::NamedBase
	
	source_root File.expand_path("../templates", __FILE__)

	argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

	include Pbw::Generators::ScaffoldHelpers
end
