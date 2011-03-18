class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :email, :location, :username, :password, :password_confirmation, :remember_me
  
  # Associations
  has_many :friendships, :foreign_key => :user_a_id
  
  # Validations
  validates :username, :presence => true, :uniqueness => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :location, :presence => true
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def self.search(search)
    if search
      where("first_name LIKE ? OR last_name LIKE ?", "%#{search}%", "%#{search}%")
    else
      scoped
    end
  end
  
  def is_friend?(another_user)
    accepted_friendships.exists?(["user_a_id = ? OR user_b_id = ?", another_user.id, another_user.id])
  end
  
  def waiting_for_confirmation?(another_user)
    friendships.exists?(:user_b_id => another_user.id, :are_friends => false)
  end
  
  def pending_friendships
    Friendship.where(:user_b_id => id, :are_friends => false)
  end
  
  def firsts_pending_friendships
    Friendship.where(:user_b_id => id, :are_friends => false).limit(5)
  end
  
  def accepted_friendships
    Friendship.where("(user_a_id = ? OR user_b_id = ?) AND are_friends = ?", id, id, true)
  end
  
  def lasts_friendships
    accepted_friendships.order("created_at DESC").limit(5)
  end
  
  def mutual_friends(another_user)
    accepted_friendships_ids = []
    
    accepted_friendships.each do |friendship|
      accepted_friendships_ids << friendship.friend(self).id
    end
    
    another_user_accepted_friendships_ids = []
    
    another_user.accepted_friendships.each do |friendship|
      another_user_accepted_friendships_ids << friendship.friend(another_user).id
    end
    
    mutual_ids = accepted_friendships_ids & another_user_accepted_friendships_ids
    
    User.find(mutual_ids)
  end
end
