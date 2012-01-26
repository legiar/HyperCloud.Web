class Slice < ActiveRecord::Base
  belongs_to :host
  belongs_to :active_host, :class_name => 'Host'
  belongs_to :network_address
  belongs_to :pool
  has_many :sites

  validates :name, :presence => true, :uniqueness => true
end
