require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  layout :get_layout

  before_filter :authenticate_user!
  #check_authorization
  #load_and_authorize_resource

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end

  private

  def get_layout
    (controller_name == "sessions" || controller_name == 'passwords') ? "login" : "application"
  end

end
