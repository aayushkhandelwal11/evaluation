class SessionsController < ApplicationController
   skip_before_filter :authorize, :except => [:destroy]

   def new
   end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have succesfully logged in"
      redirect_to todo_lists_url
    else
      flash[:error]= "Invalid username/password combination"
      redirect_to login_path 
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: "You have succesfully logged out"
  end
end
