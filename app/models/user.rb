class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :location, :share_email, :share_location, :share_activity, :post_activity, :tweet_activity
  
  # Associations
  has_many :authentications
  has_many :events
  has_many :events_users, :class_name => 'EventUser'
  has_many :friendships, :foreign_key => :user_a_id, :dependent => :destroy
  has_many :users_venues, :class_name => 'UserVenue'
  has_many :venues
  
  has_many :visited_venues, :class_name => 'Venue', :through => :users_venues, :source => :venue, :conditions => 'users_venues.visited = 1'
  has_many :venues_to_go, :class_name => 'Venue', :through => :users_venues, :source => :venue, :conditions => 'users_venues.to_go = 1'
  
  has_many :visited_events, :class_name => 'Event', :through => :events_users, :source => :event, :conditions => 'events_users.visited = 1'
  has_many :events_to_go, :class_name => 'Event', :through => :events_users, :source => :event, :conditions => 'events_users.to_go = 1'
  
  has_many :activities, :foreign_key => :user_a_id
  
  # Validations
  validates :username, :presence => true, :uniqueness => true, :format => /^[A-Za-z\d_]+$/
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :location, :presence => true
  
  PER_PAGE = 20
  LATEST = 5
  THIRD_PARTY_APPS = ['facebook', 'twitter']
  
  def self.search(search)
    if search
      where('first_name LIKE ? OR last_name LIKE ?', "%#{search}%", "%#{search}%").order('last_name ASC')
    else
      scoped
    end
  end
  
  def to_param
    username
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def accepted_friendships
    Friendship.where("(user_a_id = ? OR user_b_id = ?) AND are_friends = ?", id, id, true)
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
    
    User.where("id IN (?)", mutual_ids)
  end
  
  def is_friend?(another_user)
    accepted_friendships.exists?(["user_a_id = ? OR user_b_id = ?", another_user.id, another_user.id])
  end
  
  def waiting_for_confirmation?(another_user)
    friendships.exists?(:user_b_id => another_user.id, :are_friends => false)
  end
  
  def friendship_with_user(another_user)
    another_user.friendships.where('user_b_id = ? AND are_friends = ?', id, false).first
  end
  
  def pending_friendships
    Friendship.where(:user_b_id => id, :are_friends => false)
  end
  
  def apply_omniauth(omniauth)
    case omniauth['provider']
      when 'facebook'
        apply_facebook(omniauth)
      when 'twitter'
        apply_twitter(omniauth)
    end
    authentications.build(hash_from_omniauth(omniauth))
  end
  
  def update_omniauth(omniauth)
    if omniauth['provider'] == 'twitter'
      apply_twitter(omniauth)
      twitter_authentication.update_attributes!(hash_from_omniauth(omniauth))
    end
  end
  
  def password_required?
    #authentications.empty? || !password.blank?
    password.blank?
  end
  
  def valid_password?(password)
    not password_required? && super(password)
  end
  
  def authenticates_to?(provider)
    authentications.exists?(:provider => provider)
  end
  
  def facebook_authentication
    @facebook_authentication ||= authentications.where('provider = ?', 'facebook').first
  end
  
  def twitter_authentication
    @twitter_authentication ||= authentications.where('provider = ?', 'twitter').first
  end
  
  def facebook_friends
    users_ids = []
    
    facebook_user = FbGraph::User.me(facebook_authentication.token)
    
    facebook_user.friends.each do |facebook_friend|
      authentication = Authentication.where("uid = ?", facebook_friend.identifier).first
      if authentication
        users_ids << authentication.user_id
      end
    end
    
    if users_ids.size > 0
      @facebook_friends ||= User.where("id IN (?)", users_ids)
    else
      @facebook_friends ||= []
    end
  end
  
  def twitter_friends
    users_ids = []
    Twitter.friends(twitter_authentication.uid.to_i).users.each do |twitter_user|
      authentication = Authentication.where("uid = ?", twitter_user.id).first
      if authentication
        users_ids << authentication.user_id
      end
    end
    
    if users_ids.size > 0
      @twitter_friends ||= User.where("id IN (?)", users_ids)
    else
      @twitter_friends ||= []
    end
  end
  
  def related_activities
    ids = [id]
    
    accepted_friendships.each do |friendship|
      ids << friendship.friend(self).id
    end
    
    Activity.where('(user_a_id IN (?) OR user_b_id IN (?)) AND created_at > ?', ids, ids, created_at).order('created_at DESC').group('id')
  end
  
  def self.most_active
    users = []
    
    Activity.group('user_a_id').order('count(*) DESC').limit(10).each do |activity|
      users << activity.user_a
    end
    
    users
  end
  
  protected
  
  def apply_facebook(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      self.email = (extra['email'] rescue '')
    end
  end

  def apply_twitter(omniauth)
    if (extra = omniauth['extra']['user_hash'] rescue false)
      # Example fetching extra data. Needs migration to User model:
      # self.firstname = (extra['name'] rescue '')
    end
  end

  def hash_from_omniauth(omniauth)
    {
      :provider => omniauth['provider'], 
      :uid => omniauth['uid'], 
      :token => (omniauth['credentials']['token'] rescue nil),
      :secret => (omniauth['credentials']['secret'] rescue nil)
    }
  end
end
