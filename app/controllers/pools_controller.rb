class PoolsController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Pools", :pools_path
  
  protected
  
    def collection
      @pools ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end
