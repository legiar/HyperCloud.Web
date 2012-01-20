class DashboardController < ApplicationController
  
  def index
    @timeline = ((Time.zone.now - 30.days).to_date..(Time.zone.now - 1.day).to_date).inject([]){ |accum, date| accum << date }
    @timeline_site_errors = SiteError.full_timeline.count
  end

  protected
  
    def authenticate_user!
      unless current_user
        redirected_flash = {}
        redirected_flash[:error] = flash[:error] if flash[:error]
        redirected_flash[:notice] = flash[:notice] if flash[:notice] 
        redirect_to new_user_session_url, :flash => redirected_flash
      end
    end
    
end
