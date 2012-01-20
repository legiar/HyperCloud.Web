class SiteErrorLog < ActiveRecord::Base
  establish_connection "log"
  set_table_name "log4net"
end
