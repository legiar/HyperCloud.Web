class CreateSiteInstances < ActiveRecord::Migration
  def change
    create_table :site_instances do |t|
      t.references  :site
      t.references  :slice
      t.boolean     :enabled
      t.string      :state
      t.timestamps
    end
    add_index :site_instances, :site_id
    add_index :site_instances, :slice_id
  end
end
