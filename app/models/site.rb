class Site < ActiveRecord::Base
  belongs_to :customer
  belongs_to :database
  belongs_to :slice

  validates :name, :presence => true, :uniqueness => true
end
