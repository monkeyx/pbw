Pbw::Engine.routes.draw do
	devise_for :users, {
	    class_name: 'Pbw::User',
	    module: :devise
 	}
 	%W{areas capabilities constraints processes items tokens triggers}.each do |controller|
 		get "#{controller}/:_type" => "#{controller}\#index"
 		get "#{controller}/:_type/:id" => "#{controller}\#show"
 		post "#{controller}/:_type" => "#{controller}\#create"
 		get "#{controller}/:_type/new" => "#{controller}\#new"
 		get "#{controller}/:_type/:id/edit" => "#{controller}\#edit"
 		delete "#{controller}/:_type/:id" => "#{controller}\#delete"
 		put "#{controller}/:_type/:id" => "#{controller}\#update"
 	end
 	
 	resources :item_containers
 	resources :item_conversions
 	resources :item_transfers
 	resources :user_tokens
end
