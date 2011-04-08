class MediaFile < ActiveRecord::Base
  belongs_to :point_of_interest
  belongs_to :user
  
  mount_uploader :file, FileUploader
  
  validates :file, :presence => true
end
