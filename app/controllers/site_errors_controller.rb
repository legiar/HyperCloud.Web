class SiteErrorsController < InheritedResources::Base
  respond_to :html, :json
  actions :index, :show
  
  optional_belongs_to :site
  
  add_breadcrumb "Site errors", :site_errors_path
  
  protected
  
    def collection
      @site_errors ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(
        :per_page => 10,
        :page => params[:page])
    end
    
    def default_sort_column
      "date"
    end
    
    def default_sort_direction
      "desc"
    end
  
end

