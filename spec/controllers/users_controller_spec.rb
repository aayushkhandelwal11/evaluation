require 'spec_helper'

describe UsersController do
  describe "Action New" do
     it "should create new user" do
       get :new 
       response.should be_success
     end
  end
  describe "Action create" do
     it "should create new user if all validation passes" do
       
       post :create , :user => { :name => "xyz",
      :email => "aayushkhandelwal@vinsol.com",
      :password => "aayush11",
      :password_confirmation => "aayush11",
      }
       flash[:notice].should eq("User was successfully created.") 
       response.should_not be_success
    end
    it "should not create new user if some validation fails" do
       
       post :create , :user => { :name => "xyz",
      :email => "",
      :password => "aayush11",
      :password_confirmation => "aayush11",
      }
      response.should be_success 
      response.should render_template('users/new')
       
    end
  end
end 
