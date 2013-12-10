class ApplicationController < ActionController::Base
  protect_from_forgery

	helper_method :current_user, :autorized?
 
 # Надо подумать сессияими session[:current_user_id]
  
 protected
 
 def current_user
  	@current_user = User.find session[:current_user_id]
  end
  
  def autorized?
    return true if session[:current_user_id]
    false
  end
  
  def check_authorize
    if !autorized?
      redirect_to root_url
      return false
    end
    true
  end 
  
end
