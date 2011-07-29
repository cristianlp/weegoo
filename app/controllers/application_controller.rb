class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_mobile_preferences
  before_filter :redirect_to_mobile_version_if_applicable
  before_filter :prepend_mobile_view_path
  
  private
  
  def set_mobile_preferences
    if params[:mobile_version]
      cookies.delete(:prefer_full_version)
    elsif params[:full_version]
      cookies.permanent[:prefer_full_version] = 1
      redirect_to_full_version if is_mobile_request?
    end
  end
  
  def redirect_to_full_site
    redirect_to request.protocol + request.host_with_port.gsub(/^m\./, '') + request.request_uri and return
  end
  
  def redirect_to_mobile_version_if_applicable
    unless is_mobile_request? || cookies[:prefer_full_version] || !is_mobile_browser?
      redirect_to request.protocol + 'm.' + request.host_with_port.gsub(/^www\./, '') + request.env['REQUEST_URI'] and return
    end
  end
  
  def prepend_mobile_view_path
    prepend_view_path 'app/views/mobile_views' if is_mobile_request?
  end
  
  def is_mobile_request?
    request.subdomains.first == 'm'
  end
  helper_method :is_mobile_request?
  
  def is_mobile_browser?
    request.env['HTTP_USER_AGENT'] && request.env["HTTP_USER_AGENT"][/(iPhone|iPod|iPad|Android)/]
  end
  helper_method :is_mobile_browser?
end
