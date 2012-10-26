class Item < ActiveRecord::Base
  attr_accessible :description, :priority
  belongs_to :todo_list
  validates :description, :presence => true
  validates :priority , :numericality => true
end
