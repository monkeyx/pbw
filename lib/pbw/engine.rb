module Pbw
  class Engine < ::Rails::Engine
    isolate_namespace Pbw
    engine_name 'pbw'
    
    config.generators do |g|
	    g.orm             :mongoid
	    g.template_engine :erb
	    g.test_framework  :rspec
	    g.assets		  :false
	    g.helper		  :false
	    g.javascript_engine :coffee
	end

	def self.config(&block)
		yield Engine.config if block
		Engine.config
	end
  end
end
