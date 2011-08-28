class VenueMarkedAsToGoActivity < Activity
  protected
  
  def broadcast
    url = Rails.application.routes.url_helpers.venue_url(self.venue, :host => 'weegoo.com.ar')
    message = I18n.t('models.activities.i_marked_the_venue_as_to_go', :venue => self.venue.name, :url => url)
    tweet message
    post message
  end
end
