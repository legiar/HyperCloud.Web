class QueueJob < ActiveRecord::Base
  belongs_to :job
  has_many :queue_tasks

  scope :current, where("status < 2").order("status desc")
  scope :active, where(:status => 1)
  scope :completed, where(:status => 2)
  scope :failed, where(:status => 3)
  scope :canceled, where(:status => 4)

  after_initialize do
    if new_record?
      self.status = 0
    end
  end

  before_save do
    if new_record?
      pos = QueueJob.maximum(:position)
      pos = 0 if pos.nil?
      position = pos + 1

      job.tasks.each do |task|
        queue_tasks << QueueTask.new(:task => task)
      end
    end
  end

  after_save do |job|
    if job.canceled?
      job.queue_tasks.map{|task| task.cancel}
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
    else
      false
    end 
  end

  def status
    case read_attribute(:status)
      when 0 then "Not completed"
      when 1 then "Active"
      when 2 then "Completed"
      when 3 then "Failed"
      when 4 then "Canceled"
    end
  end

  def self.sort(ids)
    update_all(
      ['position = FIND_IN_SET(id, ?)', ids.join(',')],
      {:id => ids}
    )
  end

  private

  def status_code
    read_attribute(:status)
  end
      
end
