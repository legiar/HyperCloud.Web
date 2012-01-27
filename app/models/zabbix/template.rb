module Zabbix
  class Template < Zabbix::Host
    self.default_scopes = []
    default_scope where(:status => 3)
  end
end