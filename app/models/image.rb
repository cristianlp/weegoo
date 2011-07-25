class Image < ActiveRecord::Base
  # Associations
  belongs_to :imageable, :polymorphic => true
  belongs_to :user
  
  has_many :comments, :as => :commentable
  
  scope :latest, order('created_at DESC').limit(5)
  
  # Validations
  validates :image, :presence => true
  validates :caption, :presence => true
  
  after_create :create_image_created_activity
  
  mount_uploader :image, ImageUploader
  
  private
  
  def create_image_created_activity
    ImageCreatedActivity.create!(:user_a_id => self.user.id, :"#{self.imageable.class.to_s.underscore}_id" => self.imageable.id, :image_id => self.id)
  end
end
