class TodoList < ActiveRecord::Base
  attr_accessible :description, :items_attributes
   
  validates :description, :length => { :minimum => 3, :too_short => "Must have at least %{count} characters"}
  
  belongs_to :user
  has_many :items, :dependent => :destroy
  
  accepts_nested_attributes_for :items, :reject_if => proc { |attributes| attributes['description'].blank? }, :limit => 5
  scope :complete, lambda { includes(:items).select { |list| list.items.size == list.items.where(:items => {:completed => true}).size}  } #2n+1 query
  scope :complete1, lambda { select { |list| !list.items.exists?(:completed => :false) }  } #n+1 query
  scope :complete2, lambda { includes(:items).select { |list| list.items.size == list.items.select{ |i| i.completed?}.size}  } # 3 querys
  scope :incomplete, lambda { includes(:items).where(:items => {:completed => "false"})}
end

