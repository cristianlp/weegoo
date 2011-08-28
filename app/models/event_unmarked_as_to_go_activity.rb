class EventUnmarkedAsToGoActivity < Activity
  protected
  
  def broadcast
    url = Rails.application.routes.url_helpers.venue_event_url(self.event.venue, self.event, :host => 'weegoo.com.ar')
    message = I18n.t('models.activities.i_unmarked_the_event_as_to_go', :event => self.event.name, :url => url)
    tweet message
    post message
  end
end
