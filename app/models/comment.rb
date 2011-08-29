class Comment < ActiveRecord::Base
  # Associations
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  scope :latest, order('created_at DESC').limit(5)
  
  # Validations
  validates :content, :presence => true
  
  after_create :create_comment_created_activity
  
  private
  
  def create_comment_created_activity
    case self.commentable_type
      when 'Venue'
        CommentCreatedActivity.create!(:user_a_id => self.user.id, :venue_id => self.commentable.id)
      when 'Event'
        CommentCreatedActivity.create!(:user_a_id => self.user.id, :event_id => self.commentable.id)
      when 'Image'
        CommentCreatedActivity.create!(:user_a_id => self.user.id, :image_id => self.commentable.id)
    end
  end
end
