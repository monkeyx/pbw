module Pbw
  module Generators
    module ResourceHelpers
      
      def backbone_path
        "app/assets/javascripts"
      end
      
      def js_model_namespace
        [js_app_name, "Models", model_namespace, class_name].join(".")
      end

      def js_user_model_namespace
        [js_app_name, "Models", 'User'].join(".")
      end

      def class_namespace
        ["",model_namespace, class_name].join("::")
      end
      
      def singular_model_name
        uncapitalize singular_name.camelize
      end
      
      def plural_model_name
        uncapitalize(plural_name.camelize)
      end
      
      def collection_namespace
        [js_app_name, "Collections", model_namespace, plural_name.camelize].join(".")
      end

      def user_collection_namespace
        [js_app_name, "Collections", 'Users'].join(".")
      end

      def home_view_namespace
        [js_app_name, "Views", 'Home'].join(".")
      end
      
      def view_namespace
        [js_app_name, "Views", model_namespace, plural_name.camelize].join(".")
      end

      def user_view_namespace
        [js_app_name, "Views", 'Users'].join(".")
      end
      
      def jst(action)
        "templates/#{model_namespace.downcase}/#{plural_name}/#{action}"
      end

      def user_jst(action)
        "templates/users/#{action}"
      end

      def router_name
        [js_app_name, "Routers", 'AppRouter'].join(".")
      end
      
      def js_app_name
        application_name.camelize
      end
      
      def application_name
        if defined?(Rails) && Rails.application
          Rails.application.class.name.split('::').first
        else
          "application"
        end
      end
      
      def uncapitalize(str)
        str[0, 1].downcase << str[1..-1]
      end
      
    end
  end
end