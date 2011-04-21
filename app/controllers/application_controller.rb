require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  before_filter :authenticate_user!

  layout :get_layout

  private

  def get_layout
    (controller_name == "sessions" || controller_name == 'passwords') ? "login" : "application"
  end

end
