class NetworksController < InheritedResources::Base
  add_breadcrumb "Networks", :networks_path
  
  protected
  
    def collection
      @networks ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(
        :per_page => 10,
        :page => params[:page])
    end
    
end
