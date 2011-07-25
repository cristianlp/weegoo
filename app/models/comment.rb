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
    #CommentCreatedActivity.create!(:user_a_id => self.user.id, :"#{self.commentable.class.to_s.underscore}_id" => self.commentable.id)
  end
end
