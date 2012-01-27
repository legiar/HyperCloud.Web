class SiteInstancesController < ApplicationController
  before_filter :get_site
  
  def enable
    @instance = SiteInstance.find(params[:id])
    @instance.enable
  end

  def disable
    @instance = SiteInstance.find(params[:id])
    @instance.disable
  end
  
  private
  
  def get_site
    redirect to_sites_path unless params[:site_id]
    @site = Site.find(params[:site_id])
  end

end
