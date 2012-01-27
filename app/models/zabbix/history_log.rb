module Zabbix
  class HistoryLog < ActiveRecord::Base
    establish_connection "zabbix"
    set_table_name "history_log"
  
    belongs_to :item, :foreign_key => "itemid"
  end
end