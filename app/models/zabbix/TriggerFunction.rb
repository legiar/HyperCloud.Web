module Zabbix
  class TriggerFunction < ActiveRecord::Base
    establish_connection "zabbix"
    set_table_name "functions"
    set_primary_key "functionid"
    
    belongs_to :item, :foreign_key => "itemid"
    belongs_to :trigger, :foreign_key => "triggerid"
  end
end