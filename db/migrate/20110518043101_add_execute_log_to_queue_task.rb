class AddExecuteLogToQueueTask < ActiveRecord::Migration
  def self.up
    add_column :queue_tasks, :execute_log, :text
  end

  def self.down
    remove_column :queue_tasks, :execute_log
  end
end
