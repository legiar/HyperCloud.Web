class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :set_time_zone

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
  
  def tickets_per_page
    cookies[:tickets_per_page] || '10'
  end

  protected

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
  
  def set_time_zone
    #Time.zone = @current_user.time_zone if @current_user
  end
end
