require 'spec_helper'

describe SessionsController do
  
  before do
    @user = double(User, :id => 1, :email => "aayush.khandelwal@vinsol.com", :password => '123456')
  end
  
  describe "#CREATE" do
    
    def do_create
      post :create, :email => @user.email, :password => @user.password
    end
      
    it "should authenticate user" do
      User.stub!(:find).and_return(@user)
      User.stub!(:find_by_email).with(@user.email).and_return(@user)
      @user.stub!(:authenticate).with(@user.password).and_return(true)
      do_create
      session[:user_id].should == 1
    end
    
    context "when unauthorized" do
      before do
        User.stub!(:authenticate).and_return(nil)
      end
      
      it "should redirect to login page" do
        do_create
        response.should redirect_to login_path
      end
      
      it "should give an alert message" do
        do_create
        flash[:error].should eq "Invalid email/password combination"
      end
      
    end
  end
 
  describe "#DESTROY" do
    before do
       session[:user_id] = 1
       User.stub!(:find).and_return(@user)
       User.stub!(:current_user).and_return(@user)
    end  
    def do_destroy
       get :destroy
    end
    
    it "should set clear session" do
      User.current_user.should == @user
      do_destroy
      session[:user_id].should be_nil
    end
    
    it "should redirect to login page" do
      do_destroy
      response.should redirect_to login_url
      flash[:notice].should == "You have succesfully logged out"
    end
    
  end
end