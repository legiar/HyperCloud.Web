class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string      :name, :null => false
      t.references  :slice
      t.timestamps
      t.datetime    :deleted_at
    end
    add_index :sites, :slice_id
  end
end
