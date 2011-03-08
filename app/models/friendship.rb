class Friendship < ActiveRecord::Base
  belongs_to :user, :foreign_key => :user_a_id
  belongs_to :user, :foreign_key => :user_b_id
end
