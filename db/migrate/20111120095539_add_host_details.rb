class AddHostDetails < ActiveRecord::Migration
  def up
    add_column :hosts, :zone_id, :integer 
    add_column :hosts, :space_id, :integer 
    add_column :hosts, :status, :string
    add_column :hosts, :hypervisor, :string
    add_column :hosts, :public_vlan, :integer
    add_column :hosts, :public_ip, :string
    add_column :hosts, :public_netmask, :string
    add_column :hosts, :public_mac, :string
    add_column :hosts, :private_vlan, :integer
    add_column :hosts, :private_ip, :string
    add_column :hosts, :private_netmask, :string
    add_column :hosts, :private_mac, :string
  end

  def down
    add_column :hosts, :zone_id 
    add_column :hosts, :space_id 
    add_column :hosts, :status
    add_column :hosts, :hypervisor
    add_column :hosts, :public_vlan
    add_column :hosts, :public_ip
    add_column :hosts, :public_netmask
    add_column :hosts, :public_mac
    add_column :hosts, :private_vlan
    add_column :hosts, :private_ip
    add_column :hosts, :private_netmask
    add_column :hosts, :private_mac
  end
end
