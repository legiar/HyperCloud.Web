class AddPoolToSlice < ActiveRecord::Migration
  def change
    add_column :slices, :pool_id, :integer
    add_index :slices, :pool_id
  end
end
