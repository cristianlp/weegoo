class AcceptedFriendshipActivity < Activity
  protected
  
  def broadcast
    url = Rails.application.routes.url_helpers.user_url(self.user_a, :host => 'weegoo.com.ar')
    message = I18n.t('models.activities.user_and_i_are_now_friends_url', :user => self.user_a.full_name, :url => url)
    tweet message
    post message
  end
end
