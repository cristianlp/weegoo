class AcceptedFriendshipActivity < Activity
  #after_create :tweet
  
  private
  
  def tweet
    if self.user_b.authenticates_to?(:twitter)
      Twitter.user(self.user_b.twitter_authentication.uid.to_i)
      Twitter.update("#{self.user_a.full_name} and I are now friends: #{user_url(self.user_a)}")
    end
  end
end
