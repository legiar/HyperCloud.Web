module Zabbix
  class Application < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "applicationid"
    
    belongs_to :host, :foreign_key => "hostid"
  end
end