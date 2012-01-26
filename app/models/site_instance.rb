class SiteInstance < ActiveRecord::Base
  belongs_to :site
  belongs_to :slice
end
