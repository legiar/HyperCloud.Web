class Status

  def self.monitoring
    status = {
      "zabbix" => {:mysql => find_proccess("mysqld", "zabbix"), :zabbix => find_proccess("zabbix_server_mysql", "zabbix")},
      "zabbix-web" => {:mysql => find_proccess("mysqld", "zabbix-web"), :zabbix => find_proccess("zabbix_server", "zabbix-web")}
    }
  end

  private
  
  def self.find_proccess(name, host = "localhost")
    if host == "localhost"
      out = `ps ax | grep #{name}`
    else
      out = `ssh #{host} 'ps ax | grep #{name}'`
    end
    out.split("\n").collect do |line|
      File.basename(line.strip.split(" ").to_a.at(4))
    end.uniq.include?(name)
  end

end
