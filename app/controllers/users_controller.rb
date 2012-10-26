class UsersController < ApplicationController
  skip_before_filter :authorize
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end



  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_url, notice: 'User was successfully created.' }
      else
        format.html { render action: "new" }

      end
    end
  end

end
