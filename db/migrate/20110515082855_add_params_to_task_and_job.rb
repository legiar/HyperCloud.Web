class AddParamsToTaskAndJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :params, :string
    add_column :tasks, :params, :string
    add_column :queue_jobs, :values, :string
    add_column :queue_tasks, :values, :string
  end

  def self.down
    remove_column :jobs, :params
    remove_column :tasks, :params
    remove_column :queue_jobs, :values
    remove_column :queue_tasks, :values
  end
end
