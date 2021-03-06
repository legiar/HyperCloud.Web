class SlicesController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Slices", :slices_path
  
  protected
  
    def collection
      @slices ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
end
