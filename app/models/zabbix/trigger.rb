module Zabbix
  class Trigger < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "triggerid"
    set_inheritance_column "type_id"
    #belongs_to :action, :foreign_key => "actionid"
    #belongs_to :event, :foreign_key => "eventid"
    #belongs_to :user, :foreign_key => "userid"
    #belongs_to :mediatype, :foreign_key => "mediatypeid"
    has_many :functions, :class_name => "TriggerFunction", :foreign_key => "triggerid"
  end
end