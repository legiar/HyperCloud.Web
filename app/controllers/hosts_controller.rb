class HostsController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Hosts", :hosts_path
  
  protected
  
    def collection
      @hosts ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
end
