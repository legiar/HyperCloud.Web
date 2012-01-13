class CreateSlices < ActiveRecord::Migration
  def change
    create_table :slices do |t|
      t.string      :name, :null => false
      t.string      :state, :length => 32
      t.references  :host, :null => false
      t.references  :last_host
      t.string      :public_mac, :length => 16
      t.integer     :public_vlan, :null => false, :default => 0
      t.string      :private_mac, :length => 16
      t.integer     :private_vlan, :null => false, :default => 0
      t.integer     :cpu
      t.integer     :memory
      t.timestamps
      t.datetime  :deleted_at
    end
    add_index :slices, :host_id
    add_index :slices, :last_host_id
  end
end
