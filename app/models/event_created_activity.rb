class EventCreatedActivity < Activity
  protected
  
  def broadcast
    url = Rails.application.routes.url_helpers.venue_event_url(self.event.venue, self.event, :host => 'weegoo.com.ar')
    message = I18n.t('models.activities.i_created_the_event', :event => self.event.name, :url => url)
    tweet message
    post message
  end
end
