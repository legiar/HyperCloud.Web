class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string      :name, :null => false
      t.references  :zone, :null => false
      t.string      :mode, :length => 32, :null => false
      t.string      :address, :length => 17, :null => false 
      t.string      :gateway, :length => 17
      t.string      :dns1, :length => 15
      t.string      :dns2, :length => 15
      t.boolean     :system, :null => false, :default => false
      t.boolean     :shared, :null => false, :default => false
      t.boolean     :private, :null => false, :default => true
      t.boolean     :default, :null => false, :default => false
      t.timestamps
      t.datetime    :deleted_at
    end
    add_index :networks, :zone_id
  end
end
