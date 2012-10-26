require 'spec_helper'

describe TodoListsController do
 before do
   @user1 = mock_model(User)
   @todolist1 = double(Todolist, :id => 1, :user_id =>@user1.id)
   @todolist1.stub!(:items).and_return([])
   controller.stub(:authorize).and_return(true)
   controller.stub(:current_user).and_return(@user1)
   
 end
  describe "Action New" do
     it "should render todolist response" do
       get :new 
       response.should be_success
     end
  end
  describe "Action update" do
     before do
      controller.stub!(:check_owner?).and_return(true)
      TodoList.stub!(:find).and_return(@todolist1)
     end
     it "should succesfully update todolist" do
       @todolist1.stub!(:update_attributes).and_return(true)
       put :update, :id => @todolist1.id
       flash[:notice].should == "todolist was successfully updated."
       response.should_not be_success
     end
     it "should render edit if update todolist fails" do
       @todolist1.stub!(:update_attributes).and_return(false)
       put :update, :id => @todolist1.id
       response.should be_success
       response.should render_template("todo_lists/edit")
     end
  end

  describe "Action create" do
     before do
       x = []
       @user1.stub!(:todo_lists).and_return(x)
       x.stub!(:build).and_return(@todolist1)
     end
     it "should create new todolist" do
       
       @response1.stub!(:save).and_return(true)
       post :create      
       flash[:notice].should == "List was successfully created."
       response.should_not be_success
     end
     it "should create not create new todolist" do
       @response1.stub!(:save).and_return(false)
       post :create
       response.should be_success
       response.should render_template("todo_lists/new")
     end
  end
  describe "testing check_owner? " do
    before do
       x = []
       @user1.stub!(:todo_lists).and_return(x)
       x.stub!(:build).and_return(@todolist1)
    end
    it "validating through edit action" do
       TodoList.stub!(:find).and_return(@todolist1)
       get :edit, :id => @todolist1.id
       response.should be_success
       response.should render_template("todo_lists/edit")
      
    end
    it "generating error through edit action" do
       TodoList.stub!(:find).and_return(@todolist1)
       get :edit,  :id => 34
       flash[:error].should == "You are not authorized to view the page"
       response.should_not be_success
    end
  end
  describe "Action edit" do
    it "should edit Response" do
      controller.stub!(:check_owner?).and_return(true)
      TodoList.stub!(:find).and_return(@response1)
      get :edit, :id => @todolist1.id
      response.should be_success
      response.should render_template("todo_lists/edit")
    end
  end


end
