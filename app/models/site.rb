class Site < ActiveRecord::Base
  belongs_to :customer
  belongs_to :database
  belongs_to :slice
  belongs_to :pool
  has_many :site_errors, :foreign_key => :site, :primary_key => :name
  has_many :instances, :class_name => "SiteInstance"

  validates :name, :presence => true, :uniqueness => true
end
