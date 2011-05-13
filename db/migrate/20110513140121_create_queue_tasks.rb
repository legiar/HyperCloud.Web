class CreateQueueTasks < ActiveRecord::Migration
  def self.up
    create_table :queue_tasks do |t|
      t.references :queue_job
      t.references :task
      t.integer :status
      t.datetime :completed_at

      t.timestamps
    end
  end

  def self.down
    drop_table :queue_tasks
  end
end
