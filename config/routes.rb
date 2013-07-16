Pbw::Engine.routes.draw do
	devise_for :users, {
	    class_name: 'Pbw::User',
	    module: :devise
 	}
 	resources :areas
 	resources :capabilities
 	resources :constraints
 	resources :processes
 	resources :items
 	resources :item_containers
 	resources :item_conversions
 	resources :item_transfers
 	resources :tokens
 	resources :triggers
 	resources :user_tokens
end
