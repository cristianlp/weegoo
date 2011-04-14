class BeenAtActivity < Activity
  #after_create :tweet
  
  private
  
  def tweet
    if self.user_a.authenticates_to?(:twitter)
      Twitter.user(self.user_a.twitter_authentication.uid.to_i)
      Twitter.update("I've been at #{self.point_of_interest.name}: #{points_of_interest_url(self.point_of_interest)}")
    end
  end
end
