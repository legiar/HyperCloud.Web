class AddInfoFieldsToHost < ActiveRecord::Migration
  def self.up
    add_column :hosts, :type, :string
    add_column :hosts, :location, :string
  end

  def self.down
    remove_column :hosts, :type
    remove_column :hosts, :location
  end
end
