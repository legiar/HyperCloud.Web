module Zabbix
  class Trend < ActiveRecord::Base
    establish_connection "zabbix"
    set_table_name "trends"
    set_primary_key "itemid"
  
    belongs_to :item, :foreign_key => "itemid"
  end
end