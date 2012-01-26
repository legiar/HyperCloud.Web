class Host < ActiveRecord::Base
  belongs_to :zone
  has_many :slices
  
  validates :name, :presence => true, :uniqueness => true
  validates :public_ip, :ip_address => {:allow_blank => true} 
  validates :private_ip, :ip_address => {:allow_blank => true}
end
