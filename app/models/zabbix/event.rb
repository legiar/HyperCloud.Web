module Zabbix
  class Host < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "hostid"
  end
end