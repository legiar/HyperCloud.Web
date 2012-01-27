module Zabbix
  class Screen < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "screenid"
  
    has_many :items, :class_name => "ScreenItem", :foreign_key => "screenid"
  end
end