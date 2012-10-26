require 'spec_helper'
require_relative 'application_spec_helper'
describe Item do
  include ApplicationSpecHelper	
  before(:each) do
    @item = Item.new
  end
   describe "Relationship" do
     before(:each) do
       @item.attributes = valid_item_attributes
       @todolist = TodoList.create(valid_todo_list_attributes)
       @todolist.items = [@item]
     end 
     context "todolists" do
        it "should have a number of todolists" do 
          @item.should respond_to(:todo_list)
          
        end
        it "should have the right associated list" do
          @item.todo_list_id.should == @todolist.id
          @item.todo_list.should == @todolist
        end
     end
  end  

  describe "validations" do
    it "description should not be nil" do
      @item.attributes = valid_item_attributes.except(:description)
      @item.should have(1).error_on(:description)
    end

    it "priotity should not be a character"do
      @item.attributes = valid_item_attributes.with(:priority => "a")
      @item.should have(1).error_on(:priority)
    end
    it "should be valid" do
      @item.attributes = valid_item_attributes
      @item.should be_valid
    end

  end
end  
