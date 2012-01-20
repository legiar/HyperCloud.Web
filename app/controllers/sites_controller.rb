class SitesController < InheritedResources::Base
  respond_to :html, :json

  def show
    show! do
      @timeline = ((Time.zone.now - 30.days).to_date..(Time.zone.now - 1.day).to_date).inject([]){ |accum, date| accum << date }  
      @timeline_log = SiteErrorLog.timeline(resource.name).count 
      @max_count = 0
      @timeline_log.each_value {|v| @max_count = v unless v <= @max_count}
    end
  end  
end
