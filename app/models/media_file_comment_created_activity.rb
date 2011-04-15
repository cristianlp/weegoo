class MediaFileCommentCreatedActivity < Activity
  #after_create :tweet
  
  private
  
  def tweet
    if self.user_a.authenticates_to?(:twitter)
      Twitter.user(self.user_a.twitter_authentication.uid.to_i)
      Twitter.update("I've commented the media file of the #{self.point_of_interest.type.downcase} #{self.point_of_interest.name}: #{points_of_interest_media_file_media_file_comments_url(self.point_of_interest, self.media_file)}")
    end
  end
end
