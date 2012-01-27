class SiteInstance < ActiveRecord::Base
  belongs_to :site
  belongs_to :slice
  
  after_initialize do |model|
    if new_record?
      model.state = "Unknown"
      model.enabled = false
    end
  end
  
  def enable
    self.enabled = true
    self.state = "Starting..."
    self.save  
  end
  
  def disable
    self.enabled = false
    self.state = "Stopping..."  
    self.save  
  end
  
end
