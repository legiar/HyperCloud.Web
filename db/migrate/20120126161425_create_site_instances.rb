class CreateSiteInstances < ActiveRecord::Migration
  def change
    create_table :site_instances do |t|
      t.references  :site, :null => false
      t.references  :slice, :null => false
      t.boolean     :enabled, :null => false, :default => false
      t.string      :state
      t.timestamps
    end
    add_index :site_instances, :site_id
    add_index :site_instances, :slice_id
  end
end
