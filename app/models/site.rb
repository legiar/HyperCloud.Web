class Site < ActiveRecord::Base
  belongs_to :customer
  belongs_to :database
  belongs_to :slice
end
