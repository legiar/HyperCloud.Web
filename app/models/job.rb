class Job < ActiveRecord::Base
  has_many :job_tasks
  has_many :tasks, :through => :job_tasks
  has_many :conditions

  validates :name, :presence => true, :uniqueness => true

  accepts_nested_attributes_for :conditions, :allow_destroy => true
  accepts_nested_attributes_for :job_tasks, :allow_destroy => true
  accepts_nested_attributes_for :tasks, :allow_destroy => true

  def start(values = {}, changes = {})
    params = []
    values.each do |attr, value|
      unless value.nil?
        params << "-#{attr} #{value.to_json}"
      end
    end
    changes.each do |attr, value|
      unless value[0].nil? || attr == 'updated_at'
        params << "-old_#{attr}, #{value[0].to_json}"
      end
    end
    queue_job = QueueJob.new(:job => self, :values => params.join(' '))
    queue_job.save
  end

end
