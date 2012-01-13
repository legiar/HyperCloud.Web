class Zone < ActiveRecord::Base
  has_many :hosts
  has_many :networks
  
  validates :name, :presence => true, :uniqueness => true
end
