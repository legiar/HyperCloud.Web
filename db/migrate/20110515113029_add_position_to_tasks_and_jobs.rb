class AddPositionToTasksAndJobs < ActiveRecord::Migration
  def self.up
    add_column :job_tasks, :position, :integer
    add_column :queue_jobs, :position, :integer
    add_column :queue_tasks, :position, :integer
  end

  def self.down
    remove_column :job_tasks, :position
    remove_column :queue_jobs, :position
    remove_column :queue_tasks, :position
  end
end
