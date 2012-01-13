require "ipaddr"

class Network < ActiveRecord::Base
  belongs_to :zone
  has_many :addresses, :class_name => 'IpAddress'
  
  validates :name, :presence => true, :uniqueness => true
  validates :zone, :presence => true
  validates :address, :uniqueness => true, :ip_address => {:v4 => true, :allow_cidr => true}
  validates :gateway, :ip_address => true
  validates :dns1, :ip_address => true
  validates :dns2, :ip_address => true
  validates :begin_ip, :ip_address => true
  validates :end_ip, :ip_address => true
  
  attr_accessor :begin_ip, :end_ip
  
  after_initialize :set_default_values  
  after_create :create_ip_addresses
  
  protected
  
  def create_ip_addresses
    addr = IPAddr.new(begin_ip)
    end_addr = IPAddr.new(end_ip)
    while addr <= end_addr
      addresses << IpAddress.create(:ip => addr.to_s)
      addr = addr.succ
    end
    save
  end
  
  private
  
  def set_default_values
    if new_record?
      self.mode = "static"
    end
  end
end
