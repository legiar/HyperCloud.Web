class JobTask < ActiveRecord::Base
  belongs_to :job
  belongs_to :task
end
