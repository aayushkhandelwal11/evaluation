class TodoList < ActiveRecord::Base
  attr_accessible :description, :items_attributes
   
  validates :description, :length => { :minimum => 3, :too_short => "Must have at least %{count} characters"}
  belongs_to :user
  has_many :items

  accepts_nested_attributes_for :items, :reject_if => proc { |attributes| attributes['description'].blank? }, :limit => 5

  has_many :items
end
