class CreateQueueJobs < ActiveRecord::Migration
  def self.up
    create_table :queue_jobs do |t|
      t.references :job
      t.integer :status
      t.datetime :completed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :queue_jobs
  end
end
