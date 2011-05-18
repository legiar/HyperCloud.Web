class QueueTask < ActiveRecord::Base
  belongs_to :queue_job
  belongs_to :task

  scope :current, where(:status => 0)
  scope :active, where(:status => 1)
  scope :completed, where(:status => 2)
  scope :failed, where(:status => 3)
  scope :canceled, where(:status => 4)

  after_initialize do
    if new_record?
      self.status = 0
    end
  end

  def current?
    status_code == 0
  end

  def active?
    status_code == 1
  end

  def completed?
    status_code == 2
  end

  def failed?
    status_code == 3
  end

  def canceled?
    status_code == 4
  end

  def cancel
    if status_code == 0
      self.status = 4
      save
    end
  end

  def status
    case status_code
      when 0 then "Not completed"
      when 1 then "Active"
      when 2 then "Completed"
      when 3 then "Failed"
      when 4 then "Canceled"
    end
  end

  private

  def status_code
    read_attribute(:status)
  end

end
