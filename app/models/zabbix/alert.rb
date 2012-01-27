module Zabbix
  class Alert < ActiveRecord::Base
    establish_connection "zabbix"
    set_primary_key "alertid"
    
    belongs_to :action, :foreign_key => "actionid"
    belongs_to :event, :foreign_key => "eventid"
    belongs_to :user, :foreign_key => "userid"
    #belongs_to :mediatype, :foreign_key => "mediatypeid"
  end
end