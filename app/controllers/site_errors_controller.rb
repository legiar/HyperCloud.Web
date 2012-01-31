class SiteErrorsController < InheritedResources::Base
  respond_to :html, :datatables
  actions :index, :show
  optional_belongs_to :site
  
  add_breadcrumb "Site errors", :site_errors_path
  
  protected
  
    def collection
      @site_errors ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end

