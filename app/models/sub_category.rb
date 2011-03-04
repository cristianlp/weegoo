class SubCategory < ActiveRecord::Base
  belongs_to :category
  
  validates :name, :presence => true, :uniqueness => true, :scope => :category_id
end
