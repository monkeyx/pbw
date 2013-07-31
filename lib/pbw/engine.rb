require 'pbw/version'
require 'mongoid'
require 'devise'
require 'cancan'
require 'pbw/utils/utils'

module Pbw
  class Engine < ::Rails::Engine
    isolate_namespace Pbw
    engine_name 'pbw'

    config.mount_at = '/pbw'

    rake_tasks do
      load File.join(File.dirname(__FILE__), '../tasks/pbw_tasks.rake')
    end

    config.generators do |g|
      g.orm             :mongoid
      g.template_engine :erb
      g.test_framework  :rspec
      g.assets		  :false
      g.helper		  :false
      g.javascript_engine :coffee
    end

    config.email_from_address = 'superadmin@localhost'
    config.user_lifecycle_class = nil

    initializer "check config" do |app|
    	config.mount_at += '/'  unless config.mount_at.last == '/'
    end

    initializer "static assets" do |app|
    	app.middleware.use ::ActionDispatch::Static, "#{root}/public"
    end

    def self.version
      Pbw::VERSION
    end
  end
end
