class Friendship < ActiveRecord::Base
  belongs_to :user_a, :foreign_key => :user_a_id, :class_name => "User"
  belongs_to :user_b, :foreign_key => :user_b_id, :class_name => "User"
  
  def accept
    update_attributes!(:are_friends => true)
  end
end
