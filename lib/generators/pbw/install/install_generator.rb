require 'generators/pbw/resource_helpers'

module Pbw
	module Generators
		class InstallGenerator < Rails::Generators::Base
			include Pbw::Generators::ResourceHelpers
			source_root File.expand_path('../templates', __FILE__)
			
			class_option :skip_git, :type => :boolean, :aliases => "-G", :default => false,
                              :desc => "Skip Git ignores and keeps"

            def inject_backbone
		        inject_into_file "app/assets/javascripts/application.js", :before => "//= require_tree" do
		          "//= require underscore\n//= require backbone\n//= require backbone_rails_sync\n//= require backbone_datalink\n//= require #{application_name.underscore}\n"
		        end
		    end

		    def create_dir_layout
		        %W{routers models views templates}.each do |dir|
		          empty_directory "app/assets/javascripts/#{dir}" 
		          create_file "app/assets/javascripts/#{dir}/.gitkeep" unless options[:skip_git]
		        end
		    end

		    def create_app_file
		        template "app.coffee", "app/assets/javascripts/#{application_name.underscore}.js.coffee"
		    end

		    def config_mongoid
		    	generate "mongoid:config"
		    end

		    def add_engine_routes
		    	route "mount Pbw::Engine, :at => '/pbw'"
		    end

		    def devise_views
		    	generate "devise:views"
		    end
		end
	end
end
