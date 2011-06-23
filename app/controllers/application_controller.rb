class ApplicationController < ActionController::Base
  protect_from_forgery
  has_mobile_fu
  
  before_filter :redirect_if_mobile
  
  private
  
  def redirect_if_mobile
    if is_mobile_device?
      redirect_to "http://planetrubyonrails.com"
    end
  end
end
