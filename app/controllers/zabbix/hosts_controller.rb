class Zabbix::HostsController < Zabbix::ApplicationController 
  inherit_resources
  respond_to :html, :datatables
  
  protected
  
    def collection
      @hosts ||= end_of_association_chain.search(params[:search]).paginate(:page => params[:page], :per_page => params[:per_page])
    end
  
end
