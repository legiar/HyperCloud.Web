class Pool < ActiveRecord::Base
  has_many :slices
  has_many :sites
end
