class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  
  before_filter :authorize
 
  protected

  def authorize
    unless current_user
      flash[:error] = "Please Log in"
      redirect_to login_url
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
