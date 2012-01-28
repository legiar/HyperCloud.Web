class NetworksController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Networks", :networks_path
  
  protected
  
    def collection
      @networks ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
    
end
