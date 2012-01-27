module Zabbix
  class TrendUint < ActiveRecord::Base
    establish_connection "zabbix"
    set_table_name "trends_uint"
    set_primary_key "itemid"
  
    belongs_to :item, :foreign_key => "itemid"
  end
end