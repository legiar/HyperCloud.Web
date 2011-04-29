class Customer < ActiveRecord::Base
  has_many :databases
  has_many :sites

  validates :name, :presence => true, :uniqueness => true
end
