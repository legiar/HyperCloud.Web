class SitesController < InheritedResources::Base
  respond_to :html, :datatables
  add_breadcrumb "Sites", :sites_path
  
  def show
    show! do
      @timeline = ((Time.zone.now - 30.days).to_date..(Time.zone.now - 1.day).to_date).inject([]){ |accum, date| accum << date }  
      @timeline_log = SiteError.timeline(resource.name).count 
      @max_count = 0
      @timeline_log.each_value {|v| @max_count = v unless v <= @max_count}
      
      @site_errors = @site.site_errors.paginate(:per_page => 10, :page => params[:page])
    end
  end
  
  protected
  
    def collection
      @sites ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end

end
