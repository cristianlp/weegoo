class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :venues
  
  def to_s
    name
  end
end
