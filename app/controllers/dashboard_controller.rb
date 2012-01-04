class DashboardController < ApplicationController
  
  def index
  end

  protected
  
    def authenticate_user!
      unless current_user
        redirect_to new_user_session_url
      end
    end
  
end
