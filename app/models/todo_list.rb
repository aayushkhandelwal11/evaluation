class TodoList < ActiveRecord::Base
  attr_accessible :description, :items_attributes
   
  validates :description, :length => { :minimum => 3, :too_short => "Must have at least %{count} characters"}
  
  belongs_to :user
  has_many :items, :dependent => :destroy
  
  accepts_nested_attributes_for :items, :reject_if => proc { |attributes| attributes['description'].blank? }, :limit => 5
  scope :complete, lambda { select { |list| !list.items.exists?(:completed => :false) }  }
  scope :incomplete, lambda { includes(:items).where(:items => {:completed => "false"})}
end

