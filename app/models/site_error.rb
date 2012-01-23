class SiteError < ActiveRecord::Base
  establish_connection "log"
  set_table_name "log4net"
  
  scope :timeline, lambda {|site| where(:site => site).where('`date` >= ? and `date` <= ?',  Time.zone.now.beginning_of_day - 30.days, Time.zone.now.end_of_day - 1.day).group('date(`date`)')}
  scope :full_timeline, lambda {where('`date` >= ? and `date` <= ?',  Time.zone.now.beginning_of_day - 30.days, Time.zone.now.end_of_day - 1.day).group('date(`date`)')}
  
  scope :last, lambda {|site| where(:site => site).order('date desc')}  
end
