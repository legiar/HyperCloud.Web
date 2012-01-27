module Zabbix
  class HostsTemplate < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "hosttemplateid"
    
    belongs_to :host, :foreign_key => "hostid"
    belongs_to :template, :foreign_key => "templateid"
  end
end