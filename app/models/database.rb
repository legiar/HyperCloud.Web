class Database < ActiveRecord::Base
  belongs_to :customer
  has_one :site
end
