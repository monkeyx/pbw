module Pbw
  class BaseController < ActionController::Base
  	  respond_to :json
  	  
  	  rescue_from ::CanCan::AccessDenied do |exception|
  	  	render json: {:error => exception.message}, status: 401
	  end

	  rescue_from Mongoid::Errors::DocumentNotFound do |exception|
	  	render json: {:error => exception.message}, status: 404
	  end

	  def current_ability
	    @current_ability ||= Ability.new(current_user)
	  end
  end
end
