class Task < ActiveRecord::Base
  has_many :job_tasks
  has_many :jobs, :through => :job_tasks

  validates :name, :presence => true, :uniqueness => true

  #serialize :params, Array

  #def params=(value)
  #  if value.is_a?(Array)
  #    super
  #  elsif value.is_a?(String)
  #    write_attribute(:params, value.split(','))
  #  end
  #end

  #def params
  #  value = read_attribute(:params)
  #  value = [] if value.nil?
  #  value.join(',')
  #end
end
