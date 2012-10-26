require 'spec_helper'

describe ApplicationController do
    before do
      @user = double(User, :id => 1, :email => "aayush.khandelwal@vinsol.com", :password => '123456')
    end	
    # context "# action Authorzie" do 
    #   it "should redirect if no login"
         
    #   end

    # end	

end