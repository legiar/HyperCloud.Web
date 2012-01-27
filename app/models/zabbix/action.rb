module Zabbix
  class Action < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "actionid"
    
    has_many :conditions, :foreign_key => "actionid"
  end
end