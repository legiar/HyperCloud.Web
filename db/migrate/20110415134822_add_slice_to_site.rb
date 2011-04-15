class AddSliceToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :slice_id, :integer
  end

  def self.down
    remove_column :sites, :slice_id
  end
end
