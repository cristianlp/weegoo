class MediaFile < ActiveRecord::Base
  belongs_to :point_of_interest
  belongs_to :user
  
  mount_uploader :file, FileUploader
  
  validates :file, :presence => true
  
  after_create :create_media_file_created_activity
  
  private
  
  def create_media_file_created_activity
    MediaFileCreatedActivity.create!(:user_a_id => self.user.id, :point_of_interest_id => self.point_of_interest.id, :media_file_id => self.id)
  end
end
