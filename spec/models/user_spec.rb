require 'spec_helper'
require_relative 'application_spec_helper'
describe User do
  include ApplicationSpecHelper	
  before(:each) do
    @user = User.new
  end
   describe "Relationship" do
     before(:each) do
       @user.attributes = valid_user_attributes
       @todolist = TodoList.create(valid_todo_list_attributes)
       @todolist1 = TodoList.create(valid_todo_list_attributes)
       @user.todo_lists = [@todolist, @todolist1]
     end 
     context "todolists" do
        it "should have a number of todolists" do 
          @user.should respond_to(:todo_lists)
          @user.should have(0).error_on(:todo_lists)
        end
        it "should return an array of todolists" do
          @user.save!
          @user.todo_lists.should have(2).items
        end

        it "The user Once deleted must have no interests associated " do
          @user.save
          list_of_todo_lists = @user.todo_lists
          @user.destroy
          list_of_todo_lists.should be_empty   
        end
     end
  end  

  describe "validations" do
    it "name should not be nil" do
      @user.attributes = valid_user_attributes.except(:name)
      @user.should have(1).error_on(:name)
    end

    it "Valid name"do
      @user.attributes = valid_user_attributes.with(:name => "aayush")
      @user.should have(0).error_on(:name)
    end

    it "Email should not be null and same" do
      @user.attributes = valid_user_attributes.except(:email)
      @user.should have(1).error_on(:email)
    end

    it "Email can't be same " do
      @user2 = User.new
      @user2.attributes = valid_user_attributes
      @user2.save
      @user.attributes = valid_user_attributes
      @user.should have(1).error_on(:email)
    end
    it "should be valid" do
      @user.attributes = valid_user_attributes
      @user.should be_valid
    end
  end
end  
