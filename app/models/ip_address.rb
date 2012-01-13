class IpAddress < ActiveRecord::Base
  belongs_to :network
  belongs_to :slice
  
  validates :network, :presence => true
  validates :ip, :ip_address => true
  
  after_initialize :set_default_values
  
  private
  
  def set_default_values
    if new_record?
      self.state = 'free'
    end
  end
end
