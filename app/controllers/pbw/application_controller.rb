module Pbw
  class ApplicationController < ActionController::Base
  	  respond_to :json
  	  
  	  rescue_from ::CanCan::AccessDenied do |exception|
	    respond_to do |format|
	    	format.json {render json: {:error => exception.message}, status: 401}
	    	format.html {redirect_to root_path, :error => exception.message}
	    end
	  end

	  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
		respond_to do |format|
			format.html {redirect_to root_url, :error => exception.message}
			format.json {render json: {:error => exception.message}, status: 404}
		end
	  end

	  # Devise override
	  def after_sign_in_path_for(resource) 
	  	Pbw::Engine.user_lifecycle_class.after_signup(current_user)
	    render json: resource
	  end

	  protected

	  def current_ability
	    @current_ability ||= Ability.new(current_user)
	  end
  end
end
