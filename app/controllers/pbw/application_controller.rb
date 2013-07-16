module Pbw
  class ApplicationController < ActionController::Base
  	  
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

	  protected

	  def self.permission
	    return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
	  end

	  def current_ability
	    @current_ability ||= Ability.new(current_user)
	  end

	  def load_permissions
	    @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
	  end
  end
end
