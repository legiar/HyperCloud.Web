class Job < ActiveRecord::Base
  has_many :job_tasks
  has_many :tasks, :through => :job_tasks
end
