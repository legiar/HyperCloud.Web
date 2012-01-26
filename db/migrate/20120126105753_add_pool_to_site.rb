class AddPoolToSite < ActiveRecord::Migration
  def change
    add_column :sites, :pool_id, :integer
    add_index :sites, :pool_id
  end
end
