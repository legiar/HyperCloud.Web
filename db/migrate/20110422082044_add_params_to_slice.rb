class AddParamsToSlice < ActiveRecord::Migration
  def self.up
    add_column :slices, :active_host_id, :integer
    add_column :slices, :cpu, :integer
    add_column :slices, :memory, :integer
  end

  def self.down
    remove_column :slices, :active_host_id
    remove_column :slices, :cpu
    remove_column :slices, :memmory
  end
end
