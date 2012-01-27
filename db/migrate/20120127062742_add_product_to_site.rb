class AddProductToSite < ActiveRecord::Migration
  def change
    add_column :sites, :product_id, :integer
    add_index :sites, :product_id
  end
end
