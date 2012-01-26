class Slice < ActiveRecord::Base
  belongs_to :host
  belongs_to :last_host, :class_name => 'Host'
  belongs_to :network_address
  belongs_to :pool
  has_many :site_instances
  has_many :sites, :through => :site_instances 

  validates :name, :presence => true, :uniqueness => true
end
