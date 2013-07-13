$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pbw/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pbw"
  s.version     = Pbw::VERSION
  s.authors     = ["Seyed P. Razavi"]
  s.email       = ["monkeyx@gmail.com"]
  s.homepage    = "http://github.com/monkeyx/pbw"
  s.summary     = "A Rails Engine for Play By Web games"
  s.description = "Provides engine and generators for building web games using common components"

  s.files = Dir["{app,config,db,lib,vendor}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency('rails', '~> 3.2.13')
  s.add_dependency('coffee-script', '~> 2.2.0')
  s.add_dependency('jquery-rails', '~> 2.1.3')
  s.add_dependency('ejs', '~> 1.1.1')
  s.add_dependency('devise', '~> 2.2.4')
  s.add_dependency('activemodel','~> 3.2')
  s.add_dependency('mongoid', '~> 3.1.4')

  s.add_development_dependency('sass')
  s.add_development_dependency('uglifier')
  s.add_development_dependency('rspec')

  s.require_paths = ['lib']

end
