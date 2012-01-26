class SiteInstance < ActiveRecord::Base
  belongs_to :site
  belongs_to :slice
  
  after_initialize do |model|
    if new_record?
      model.state = "Unknown"
      model.enabled = false
    end
  end
end
