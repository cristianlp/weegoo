class Activity < ActiveRecord::Base
  belongs_to :user_a, :foreign_key => :user_a_id, :class_name => 'User'
  belongs_to :user_b, :foreign_key => :user_b_id, :class_name => 'User'
  belongs_to :venue
  belongs_to :event
  belongs_to :image
  
  after_create :broadcast
  
  PER_PAGE = 20
  
  protected
  
  def tweet(message)
    #return unless Rails.env == 'production' # only tweet the message if the rails environment is production
    
    return unless self.user_a.tweet_activity?
    
    if self.user_a.authenticates_to?(:twitter)
      twitter_auth = self.user_a.twitter_authentication
      if !twitter_auth.token.blank? && !twitter_auth.secret.blank?
        twitter_user = Twitter::Client.new(:oauth_token => twitter_auth.token, :oauth_token_secret => twitter_auth.secret) rescue nil
        twitter_user.update message
      end
    end
  end
  
  def post(message)
    #return unless Rails.env == 'production' # only post the message if the rails environment is production
    
    return unless self.user_a.post_activity?
    
    if self.user_a.authenticates_to?(:facebook)
      user = FbGraph::User.me(self.user_a.facebook_authentication.token)
      user.feed!(:message => message)
    end
  end
end
