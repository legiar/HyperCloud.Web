module Zabbix
  class History < ActiveRecord::Base
    establish_connection "zabbix"
    set_table_name "history"
    set_primary_key "itemid"
  
    belongs_to :item, :foreign_key => "itemid"
  end
end