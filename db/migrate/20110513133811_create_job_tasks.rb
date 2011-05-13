class CreateJobTasks < ActiveRecord::Migration
  def self.up
    create_table :job_tasks do |t|
      t.references :job
      t.references :task
      t.timestamps
    end
  end

  def self.down
    drop_table :job_tasks
  end
end
