class SlicesController < InheritedResources::Base
  add_breadcrumb "Slices", :slices_path
  
  protected
  
    def collection
      @slices ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(
        :per_page => 10,
        :page => params[:page])
    end

    def default_sort_column
      "name"
    end
end
