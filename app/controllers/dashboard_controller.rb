class DashboardController < ApplicationController
  before_filter :set_current_tab
  
  def index
    @timeline = ((Time.zone.now - 30.days).to_date..(Time.zone.now - 1.day).to_date).inject([]){ |accum, date| accum << date }
    @timeline_site_errors = SiteErrorLog.full_timeline.count
    
    #@active_tickets = Ticket.not_closed.active_tickets
    #@closed_tickets = Ticket.closed_tickets

    # create array of date strings from 30 days ago up to yesterday
    #

    #@timeline_opened_tickets = Ticket.timeline_opened_tickets
    #@timeline_closed_tickets = Ticket.timeline_closed_tickets

    #@max_opened = 0
    #@max_closed = 0

    #@timeline_opened_tickets.each_value do |v|
    #  @max_opened = v unless v <= @max_opened
    #end

    #@timeline_closed_tickets.each_value do |v|
    #  @max_closed = v unless v <= @max_closed
    #end    
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
    
  private 
  
    def set_current_tab
      @current_tab = :dashboard
    end  
  
end
