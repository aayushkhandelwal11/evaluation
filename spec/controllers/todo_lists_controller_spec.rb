require 'spec_helper'

describe ResponsesController do
 before do
   @todolist1 = double(Todolist, :id => 1)
   controller.stub(:authorize).and_return(true)
   @user1 = mock_model(User)
   controller.stub(:current_user).and_return(@user1)

 end
  describe "Action New" do
     it "should render new response" do
       get :new , :user_id => @user1.id
       response.should be_success
     end
  end
  describe "Action update" do
  	 before do
  	 	controller.stub!(:is_valid_access?).and_return(true)
        Response.stub!(:find).and_return(@response1)
     end
     it "should succesfully update response" do
       @response1.stub!(:update_attributes).and_return(true)
       put :update, :id => @response1.id
       flash[:notice].should == "Response was succesfully updated"
       response.should_not be_success
     end
     it "should render edit if update response fails" do
       @response1.stub!(:update_attributes).and_return(false)
       put :update, :id => @response1.id
       response.should be_success
       response.should render_template("responses/edit")
     end
  end

  describe "Action create" do
  	 before do
       @user1.stub!(:build_response).and_return(@response1)
     end
     it "should create new Response" do
       
       @response1.stub!(:save).and_return(true)
       post :create      
       flash[:notice].should == "Response was succesfully recorded"
       response.should_not be_success
     end
     it "should create new Response" do
       @response1.stub!(:save).and_return(false)
       post :create
       response.should be_success
       response.should render_template("responses/new")
     end
  end
  describe "Testing is_valid_access? " do
    it "validating through edit action" do
       @user1.stub!(:response).and_return(@response1)
       Response.stub!(:find).and_return(@response1)
       get :edit, :user_id => @user1.id, :id => @response1.id
       response.should be_success
       response.should render_template("responses/edit")
      
    end
    it "generating error through edit action" do
       @user1.stub!(:response).and_return(@response1)
       Response.stub!(:find).and_return(@response1)
       get :edit, :user_id => @user1.id, :id => 34
       flash[:error].should == "You are not authorized to view the page"
       response.should_not be_success
    end
  end
  describe "Action edit" do
    it "should edit Response" do
      controller.stub!(:is_valid_access?).and_return(true)
      Response.stub!(:find).and_return(@response1)
      get :edit, :user_id => @user1.id, :id => @response1.id
      response.should be_success
      response.should render_template("responses/edit")
    end
  end


end
