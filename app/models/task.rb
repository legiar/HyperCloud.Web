class Task < ActiveRecord::Base
  has_many :job_tasks
  has_many :jobs, :through => :job_tasks

  validates :name, :presence => true, :uniqueness => true
end
