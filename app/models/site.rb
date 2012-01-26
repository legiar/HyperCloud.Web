class Site < ActiveRecord::Base
  belongs_to :customer
  belongs_to :database
  belongs_to :slice
  belongs_to :pool
  has_many :site_errors, :foreign_key => :site, :primary_key => :name

  validates :name, :presence => true, :uniqueness => true
end
