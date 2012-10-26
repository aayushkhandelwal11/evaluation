class Item < ActiveRecord::Base
  attr_accessible :description, :priority

  validates :description, :presence => true
  validates :priority , :numericality => true
end
