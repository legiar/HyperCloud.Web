module Zabbix
  class Group < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "groupid"
  
    has_many :hosts_groups, :foreign_key => "groupid"
    has_many :hosts, :through => :hosts_groups
    
    default_scope where(:internal => 0)  
  end
end