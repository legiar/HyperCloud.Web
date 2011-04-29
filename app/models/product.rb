class Product < ActiveRecord::Base
  validates :name, :presence => true
  validates :version, :presence => true, :format => {:with => /^\d+\.\d+\.\d+\.\d+(-\d+){0,1}$/}
end
