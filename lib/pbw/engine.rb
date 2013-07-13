module Pbw
  class Engine < ::Rails::Engine
    isolate_namespace Pbw
    config.generators do |g|
	    g.orm             :mongoid
	    g.template_engine :erb
	    g.test_framework  :rspec
	    g.assets		  :false
	    g.helper		  :false
	    g.javascript_engine :coffee
	end
	config.mongoid.logger = Logger.new($stdout, :warn)
  end
end
