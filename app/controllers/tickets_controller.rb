class TicketsController < InheritedResources::Base
  respond_to :html, :json
  add_breadcrumb "Tickets", :tickets_path
  
  #before_filter :require_user
  #before_filter :set_current_tab
  #before_filter :lookup_ticket, :only => [:edit, :update, :destroy]
  #before_filter :get_alert, :only => [:show]
  #cache_sweeper :audit_sweeper
  
  def index1
    @tickets_per_page = tickets_per_page
    #@search = Ticket.search(params[:search])
    @closed_status = TicketStatus.closed.first
    @open_status = TicketStatus.open.first

    if params[:search]
      if !params[:search][:created_at_gte].blank?
        start_date = Date.strptime(params[:search][:created_at_gte],"%Y-%m-%d")
        @search.created_at_gte = start_date
        start_date = start_date.midnight.gmtime
        params[:search][:created_at_gte] = start_date.midnight
      end
      if !params[:search][:created_at_lt].blank?
        end_date = Date.strptime(params[:search][:created_at_lt],"%Y-%m-%d")
        @search.created_at_lt = end_date
        end_date = end_date.next.midnight.gmtime
        params[:search][:created_at_lt] = end_date.midnight
      end
      @tickets = Ticket.search(params[:search]).paginate(
        :page => params[:page],
        :include => [:creator, :owner, :group, :status, :priority, :contact],
        :order => 'updated_at DESC',
        :per_page => @tickets_per_page)
    else
      @tickets = Ticket.not_closed.paginate(
        :page => params[:page],
        :include => [:creator, :owner, :group, :status, :priority, :contact],
        :order => 'updated_at DESC',
        :per_page => @tickets_per_page)
    end

    @total_tickets = @tickets.total_entries

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.xml  { render :xml => @tickets }
    end
  end

  def show1
    begin
      @ticket = Ticket.find(params[:id], :include => { :comments => :user, :attachments => :user })
    rescue ActiveRecord::RecordNotFound
      logger.error(":::Attempt to access invalid ticket_id => #{params[:id]}")
      flash[:error] = "You have requested an invalid ticket!"
      redirect_to tickets_path and return
    end

    respond_to do |format|
      format.html # show.html.erb
      format.pdf { render :layout => false }
      format.xml  { render :xml => @ticket }
    end
  end

  def new1
    @ticket = Ticket.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ticket }
    end
  end

  def edit1
  end

  def create1
    # scope creation of new ticket to current_user
    @ticket = @current_user.created_tickets.build(params[:ticket])

    respond_to do |format|
      if @ticket.save
        flash[:success] = "Ticket ##{@ticket.id} was successfully created!"
        format.html { redirect_to(@ticket) }
        format.xml  { render :xml => @ticket, :status => :created, :location => @ticket }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update1
    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        flash[:success] = 'Ticket was successfully updated!'
        format.html { redirect_to(@ticket) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ticket.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy1
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to(tickets_url) }
      format.xml  { head :ok }
    end
  end

  # Sets a cookie on the user's browser to indicate the tickets per page value
  def set_tickets_per_page
    @per_page = params[:per_page]
    cookies[:tickets_per_page] = { :value => "#{@per_page}", :expires => 1.year.from_now }
    flash[:success] = "You are now viewing #{@per_page} tickets per page!"
    redirect_to tickets_path
  end

  private

  def lookup_ticket
    begin
      @ticket = Ticket.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error(":::Attempt to access invalid ticket_id => #{params[:id]}")
      flash[:error] = "You have requested an invalid ticket!"
      redirect_to tickets_path and return
    end
  end

  def get_alert
    @alert = Alert.find_by_user_id_and_ticket_id(@current_user.id, params[:id])
  end
  
  protected
    
    def collection
      @search = Ticket.search(params[:search])
      @tickets ||= end_of_association_chain.search(params[:search]).order(sort_column + ' ' + sort_direction).paginate(
        :page => params[:page],
        :per_page => 5)
    end  
    
end
