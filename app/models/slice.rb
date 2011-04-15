class Slice < ActiveRecord::Base
  belongs_to :host
  belongs_to :network_address
  has_many :sites
end
