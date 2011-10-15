class Event < ActiveRecord::Base
  # Associations
  belongs_to :venue
  belongs_to :user
  
  has_many :comments, :as => :commentable
  has_many :images, :as => :imageable
  
  has_many :events_users, :class_name => 'EventUser'
  
  has_many :visitors, :class_name => 'User', :through => :events_users, :source => :user, :conditions => 'events_users.visited = 1'
  has_many :possible_visitors, :class_name => 'User', :through => :events_users, :source => :user, :conditions => 'events_users.to_go = 1'
  
  scope :upcoming, where('start_date >= ?', "#{Time.now.strftime("%Y-%m-%d %H:%M:%S")}").order('start_date')
  
  # Validations
  validates :name, :presence => true, :uniqueness => true
  validates :start_date, :presence => true
  
  acts_as_ferret :fields => [
    :name,
    :description
  ], :additional_fields => [
    :category,
    :sub_category
  ]
  
  # Callbacks
  # because permalink_fu does not escape the name automatically:
  before_save :handle_permalink
  has_permalink :name, :update => true
  
  after_create :create_event_created_activity
  
  PER_PAGE = 20
  LATEST = 5
  
  def self.search(search)
    if search
      where('(name LIKE ? OR description LIKE ?)', "%#{search}%", "%#{search}%").order('name ASC')
    else
      scoped
    end
  end
  
  def to_param
    permalink
  end
  
  def can_delete?(user)
    visitors.size == 0 and possible_visitors.size == 0 and self.user == user
  end
  
  def can_edit?(user)
    self.user == user
  end
  
  protected
  
  def handle_permalink
    self.permalink = PermalinkFu.escape self.name
  end
  
  private
  
  def create_event_created_activity
    EventCreatedActivity.create!(:user_a_id => self.user.id, :event_id => self.id)
  end
end
