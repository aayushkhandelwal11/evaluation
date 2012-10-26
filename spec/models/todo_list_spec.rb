require 'spec_helper'
require_relative 'application_spec_helper'

describe TodoList do
  include ApplicationSpecHelper	
  before(:each) do
    @todolist = TodoList.new
  end
  describe "Validations" do
    it "can be instantiated" do
      TodoList.new.should be_an_instance_of(TodoList)
    end
    it "Description can't be less then 3 characters" do
      @todolist.attributes = valid_todo_list_attributes.with(:description => "qw")
      @todolist.should have(1).error_on(:description)
    end
    
    it "should be valid" do
      @todolist.attributes = valid_todo_list_attributes
      @todolist.should be_valid
    end
  end  

  describe "Relationships" do 
    before(:each) do
      @todolist1 = TodoList.create(valid_todo_list_attributes)
      @item1 = @todolist1.items.create(valid_item_attributes)
      @item2 = @todolist1.items.create(valid_item_attributes.with(:description => "xyz"))
    end
    describe "user associations" do
      before(:each) do
        @user = User.create(valid_user_attributes)
        @user.todo_lists = [@todolist1]
      end
      it "should have a user attribute" do
        @todolist1.should respond_to(:user)
      end

      it "should have the right associated user" do
        @todolist1.user_id.should == @user.id
        @todolist1.user.should == @user
      end
    end 
    context "items" do
      it "should return an array of items" do
        @todolist1.items.should have(2).items
      end
      it "should respond to items" do
        @todolist1.should respond_to(:items)
      end
      it "The user Once deleted must have no interests associated " do
        @todolist1.save
        list_of_items = @todolist1.items
        @todolist1.destroy
        list_of_items.should be_empty   
      end
    end
  end

end
