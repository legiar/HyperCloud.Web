class Network < ActiveRecord::Base
  has_many :addreses, :class_name => 'NetworkAddress'
end
