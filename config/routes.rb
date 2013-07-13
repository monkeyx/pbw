Pbw::Engine.routes.draw do
	devise_for :users, {
	    class_name: 'Pbw::User',
	    module: :devise
 	}
end
