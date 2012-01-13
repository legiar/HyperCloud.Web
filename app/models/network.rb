require "ipaddr"

class Network < ActiveRecord::Base
  belongs_to :zone
  has_many :addresses, :class_name => 'IpAddress'
  
  validates :name, :presence => true, :uniqueness => true
  validates :address, :presence => true, :uniqueness => true, :ip_address => true, :allow_cidr => true
  validates :gateway, :presence => true, :ip_address => true
  #validates :begin_ip, :ip_address => true
  #validates :end_ip, :ip_address => true
  
  attr_writer :begin_ip, :end_ip  
  after_create :create_ip_addresses
  
  def begin_ip
    
  end
  
  protected
  
  def create_ip_addresses
    addr = IPAddr.new(begin_ip)
    end_addr = IPAddr.new(end_ip)
    while addr <= end_addr
      addresses << NetworkAddress.create(:ip => addr.to_s)
      addr = addr.succ
    end
    save
  end
end
