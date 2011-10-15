class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :venues
  
  def to_s
    name
  end
end
