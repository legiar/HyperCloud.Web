require "ipaddr"

class Network < ActiveRecord::Base
  has_many :addresses, :class_name => 'NetworkAddress'
  
  validates :name, :presence => true, :uniqueness => true
  validates :address, :presence => true, :uniqueness => true
  validates :netmask, :presence => true
  validates :gateway, :presence => true
  validates :begin_ip, :ip_address => true
  validates :end_ip, :ip_address => true
  
  after_save :create_addresses
  
  protected
  
  def create_addresses
    if addresses.count == 0
      addr = IPAddr.new(begin_ip)
      end_addr = IPAddr.new(end_ip)
      while addr <= end_addr
        addresses << NetworkAddress.create(:ip => addr.to_s)
        addr = addr.succ
      end
      save
    end
  end
end
