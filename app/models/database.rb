class Database < ActiveRecord::Base
  belongs_to :customer
  has_one :site

  validates :name, :presence => true, :uniqueness => true
  validates :password, :presence => true, :length => {:minimum => 6}
end
