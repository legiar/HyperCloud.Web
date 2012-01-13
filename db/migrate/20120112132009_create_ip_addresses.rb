class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.references  :network, :null => false
      t.string      :ip, :length => 15, :null => false
      t.string      :state, :length => 32, :null => false
      t.datetime    :allocated_at
      t.references  :slice
      t.timestamps
      t.datetime    :deleted_at
    end
    add_index :ip_addresses, :network_id
    add_index :ip_addresses, :slice_id
  end
end
