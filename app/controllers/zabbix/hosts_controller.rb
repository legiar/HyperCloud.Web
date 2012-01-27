class Zabbix::HostsController < Zabbix::ApplicationController 
  inherit_resources
  
  protected
  
    def collection
      @hosts ||= end_of_association_chain.order(sort_column + ' ' + sort_direction).paginate(
        :per_page => 10,
        :page => params[:page])
    end
    
    def default_sort_column
      "host"
    end
  
end
