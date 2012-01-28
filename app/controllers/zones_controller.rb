class ZonesController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "System", :system_path
  add_breadcrumb "Zones", :zones_path
  
  protected
  
    def collection
      @zones ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end
