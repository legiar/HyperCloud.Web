class AddDatabaseToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :database_id, :integer
  end

  def self.down
    remove_column :sites, :database_id
  end
end
