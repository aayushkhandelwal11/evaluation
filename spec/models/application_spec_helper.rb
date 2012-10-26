module ApplicationSpecHelper

  
  def valid_todo_list_attributes
    { :description => "abc"
    }
  end  

  def valid_user_attributes
    { :name => "aayush",
      :email => "aayus.h.khandelwal@vinsol.com",
      :password => "aayush11",
      :password_confirmation => "aayush11",
    }
   end  
  def valid_item_attributes
    { :description => "abc",
      :priority => 3
     }  
  end
end