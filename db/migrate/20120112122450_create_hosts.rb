class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string      :name, :null => false
      t.string      :state, :length => 32
      t.references  :zone, :null => false
      t.string      :public_mac, :length => 16
      t.integer     :public_vlan, :null => false, :default => 0
      t.string      :public_ip, :length => 15
      t.string      :public_netmask, :length => 15
      t.string      :private_mac, :length => 16
      t.integer     :private_vlan, :null => false, :default => 0
      t.string      :private_ip, :length => 15
      t.string      :private_netmask, :length => 15
      t.timestamps
      t.datetime    :deleted_at
    end
    add_index :hosts, :zone_id
  end
end
