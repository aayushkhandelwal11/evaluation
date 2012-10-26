class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :email, :name, :password, :password_confirmation

  validates :name, :length => { :minimum => 3, :too_short => "Must have at least %{count} characters"}
  validates :password, :length => { :minimum => 6, :too_short => "Must have at least %{count} characters"}, :if => :password
  validates :email, :presence => {:message => "This field can't be left blank"} 
  validates :email, :uniqueness => {:case_sensitive => false}, :if => :email 
  validates :email, :format => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :if => lambda {self.email.present? } 


  has_many :todo_lists, :dependent => :destroy
end
