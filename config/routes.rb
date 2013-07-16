Pbw::Engine.routes.draw do
	devise_for :users, {
	    class_name: 'Pbw::User',
	    module: :devise
 	}
 	resources :areas
 	resources :capabilities
 	resources :constraints
 	resources :processes
 	resources :resources
 	resources :resource_containers
 	resources :resource_conversions
 	resources :resource_transfers
 	resources :tokens
 	resources :triggers
 	resources :user_tokens
end
