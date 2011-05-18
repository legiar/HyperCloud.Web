class AddValuesToQueueJob < ActiveRecord::Migration
  def self.up
    add_column :queue_jobs, :values, :text
  end

  def self.down
    remove_column :queue_jobs, :values
  end
end
