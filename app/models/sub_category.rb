class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :points_of_interest
  
  validates :name, :presence => true, :uniqueness => true, :scope => :category_id
end
