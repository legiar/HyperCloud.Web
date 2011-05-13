class QueueJob < ActiveRecord::Base
  belongs_to :job
  has_many :queue_tasks

  scope :current, where(:status => 0)
  scope :completed, where(:status => 1)
  scope :active, where(:status => 2)
  scope :failed, where(:status => 3)

  def completed?
    self.status == 1
  end

  def active?
    self.status == 2
  end

  def failed?
    self.status == 3
  end

  def status
    case self.status
      when 0 then "Not completed"
      when 1 then "Completed"
      when 2 then "Active"
      when 3 then "Failed"
    end
  end
      
end
