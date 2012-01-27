module Zabbix
  class Graph < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "graphid"
    has_many :items, :class_name => "GraphItem", :foreign_key => "graphid"
  end
end