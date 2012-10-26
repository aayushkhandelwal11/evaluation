require 'spec_helper'
describe User do
  include ApplicationSpecHelper	
  before(:each) do
    @user = User.new
  end
   describe "Relationship" do
     before(:each) do
       @user.attributes = valid_user_attributes
       @todolist = TodoList.create(valid_todo_list_attributes)
       @user.todolist = @todolist
     end 
     context "todolists" do
        it "should have a number of todolists" do 
          @user.should respond_to(:todolists)
          @user.should have(0).error_on(:interests)
        end
        it "should return an array of interests" do
          @user.save!
          @user.interests.should have(3).items
        end

        it "The user Once deleted must have no interests associated " do
          @user.save
          list_of_interests = @user.interests
          @user.destroy
          list_of_interests.should be_empty   
        end
     end
     context "response" do
        it "should have a response" do 
          @user.should respond_to(:response)
          @user.should have(0).error_on(:response)
        end

        it "should have a single response" do
          @user.response.should == @response
        end

        it "should destroy associated response" do
          @user.destroy
          [@response].each do |response|
            lambda do
              Response.find(response)
            end.should raise_error(ActiveRecord::RecordNotFound)
          end
        end
     end
  end  

  describe "validations" do
    it "name should not be nil" do
      @user.attributes = valid_user_attributes.except(:name)
      @user.should have(1).error_on(:name)
    end
    
   
    it "user name should not be nil" do
      @user.attributes = valid_user_attributes.except(:username)
      @user.should have(1).error_on(:username)
    end

    it "User name can't be same " do
      @user2 = User.new
      @user2.attributes = valid_user_attributes
      @user2.save
      @user.attributes = valid_user_attributes
      @user.should have(1).error_on(:username)
    end

    it "Valid user name"do
      @user.attributes = valid_user_attributes.with(:username => "xyz123")
      @user.should have(0).error_on(:username)
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
    it "Valid Email"do
      @user.attributes = valid_user_attributes.with(:email => "abc@xyz.com")
      @user.should have(0).error_on(:email)
    end
    it "Invalid imape type"do
      @user.attributes = valid_user_attributes.with(:avatar_content_type => 'pdf')
      @user.should have(1).error_on(:avatar_content_type)
    end

    it "Invalid image size"do
      @user.attributes = valid_user_attributes.with(:avatar_file_size => 171852324)
      @user.should have(1).error_on(:avatar_file_size)
    end

    it "Address should be valid"do
      @user.attributes = valid_user_attributes.with(:state => '!234sd', :country => '!234sd')
      @user.should have(1).error_on(:gmaps4rails_address)
    end

    it "Invalid Password short of length "do
      @user.attributes = valid_user_attributes.with(:password=>"wer")
      @user.should have(2).error_on(:password)
    end
    it "Password not matching confirmation"do
      @user.attributes = valid_user_attributes.with(:password=>"qwertyuiop")
      @user.should have(1).error_on(:password)
    end

    it "should be valid" do
      @user.attributes = valid_user_attributes
      @user.should be_valid
    end
  end
end  
