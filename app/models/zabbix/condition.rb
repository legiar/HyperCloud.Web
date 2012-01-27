module Zabbix
  class Condition < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "conditionid"

    belongs_to :action, :foreign_key => "actionid"
  end
end