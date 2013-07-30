Pbw::Engine.routes.draw do
	devise_for :users, {
	    class_name: 'Pbw::User',
	    controllers: { registrations: 'pbw/registrations', :sessions => 'pbw/sessions', :passwords => 'pbw/passwords'},
	    module: :devise
 	}
 	%W{areas commands items tokens}.each do |controller|
 		get "#{controller}/:_type" => "#{controller}\#index"
 		get "#{controller}/:_type/:id" => "#{controller}\#show"
 		post "#{controller}/:_type" => "#{controller}\#create"
 		delete "#{controller}/:_type/:id" => "#{controller}\#destroy"
 		put "#{controller}/:_type/:id" => "#{controller}\#update"
 	end

 	%W{areas tokens}.each do |controller|
 		get "#{controller}/:_type/:container_id/items" => "item_containers\#index"
 		get "#{controller}/:_type/:container_id/items/:id" => "item_containers\#show"
 		post "#{controller}/:_type/:container_id/items" => "item_containers\#create"
 		delete "#{controller}/:_type/:container_id/items/:id" => "item_containers\#destroy"
 		put "#{controller}/:_type/:container_id/items/:id" => "item_containers\#update"
 	end

 	get "users/items" => "item_containers\#index"
 	get "users/items/:id" => "item_containers\#show"
 	post "users/items" => "item_containers\#create"
 	put "users/items/:id" => "item_containers\#update"
 	delete "users/items/:id" => "item_containers\#destroy"
end
