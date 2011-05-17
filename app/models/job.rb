class Job < ActiveRecord::Base
  has_many :job_tasks
  has_many :tasks, :through => :job_tasks
  has_many :conditions

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :conditions
  accepts_nested_attributes_for :job_tasks
  accepts_nested_attributes_for :tasks

  def start(object, values = {})
    logger.debug "  = Start job '#{self.name}' for object '#{object.class.name}' with ID=#{object.id}"
    queue_job = QueueJob.new(:job => self)
    tasks.each do |task|
      queue_job.queue_tasks << QueueTask.new(:task => task)
    end
    queue_job.save
  end
end
