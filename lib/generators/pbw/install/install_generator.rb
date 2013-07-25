require 'generators/pbw/resource_helpers'

module Pbw
	module Generators
		class InstallGenerator < Rails::Generators::Base
			include Pbw::Generators::ResourceHelpers

			source_root File.expand_path("../../templates", __FILE__)

			class_option :skip_git, :type => :boolean, :aliases => "-G", :default => false,
                              :desc => "Skip Git ignores and keeps"

            def inject_backbone
		        inject_into_file "app/assets/javascripts/application.js", :before => "//= require_tree" do
		          "//= require underscore\n//= require backbone\n//= require backbone_rails_sync\n//= require backbone_datalink\n//= require #{application_name.underscore}\n"
		        end
		    end

		    def create_router_file 
				template 'router.coffee', File.join(backbone_path, "routers", "app_router.js.coffee")
			end

			def create_home_view
				template "views/home.coffee", File.join(backbone_path, "views/home", "index_view.js.coffee")
				template "templates/home.jst", File.join(backbone_path, "templates/home", "index.jst.ejs") 
			end

			def create_home_controller
				template "index.erb", "app/views/home/index.html.erb"
				generate "controller", "home index --skip"
				gsub_file "config/routes.rb", "get \"home/index\"", "root :to => \"home#index\""
			end

		    def create_dir_layout
		        %W{helpers routers models views templates}.each do |dir|
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

		    def create_user_backbone
		    	template "user.coffee", "app/assets/javascripts/models/user.js.coffee"
		    	template "user_recovery.coffee", "app/assets/javascripts/models/user_recovery.js.coffee"
		    	template "user_session.coffee", "app/assets/javascripts/models/user_session.js.coffee"
		    	template "views/login_view.coffee", "app/assets/javascripts/views/users/ogin_view.js.coffee"
		    	template "views/recovery_view.coffee", "app/assets/javascripts/views/users/recovery_view.js.coffee"
		    	template "views/signup_view.coffee", "app/assets/javascripts/views/users/signup_view.js.coffee"
		    	template "templates/login.jst", "app/assets/javascripts/templates/users/login.jst.ejs"
		    	template "templates/recover_password.jst", "app/assets/javascripts/templates/users/recover_password.jst.ejs"
		    	template "templates/signup.jst", "app/assets/javascripts/templates/users/signup.jst.ejs"
		    end

		    def user_lifecycle
		    	template "lifecycle.rb", "app/models/user/lifecycle.rb"
		    end

		    def create_helper_javascript
		    	template "pbw.coffee", "app/assets/javascripts/helpers/pbw.js.coffee"
		    end
		end
	end
end
