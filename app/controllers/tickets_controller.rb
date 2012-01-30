class TicketsController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Tickets", :tickets_path
  
  def create
    #@ticket = @current_user.authored_tickets.build(params[:ticket])
    @ticket = Ticket.new(params[:ticket])
    @ticket.author = current_user
    @ticket.owner = current_user
    create!
  end

  protected
    
    def collection
      @tickets ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end  
    
end
