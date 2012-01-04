class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :layout_by_resource

  #before_filter :ensure_proper_protocol
  before_filter :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  protected

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
  
  def ssl_allowed_action?
    (params[:controller] == 'users/sessions' && ['new', 'create'].include?(params[:action])) ||
      (params[:controller] == 'users/registrations' && ['new', 'create', 'edit', 'update'].include?(params[:action])) ||
      (params[:controller] == 'users/omniauth_callbacks')
  end
  
  def ensure_proper_protocol
    if request.ssl? && !ssl_allowed_action?
      redirect_to "http://" + request.host + request.fullpath
    end
  end
  
  def after_sign_in_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end
  
  def after_sign_out_path_for(resource_or_scope)
    root_url(:protocol => 'http')
  end
  
end
