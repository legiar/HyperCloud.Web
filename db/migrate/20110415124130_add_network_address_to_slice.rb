class AddNetworkAddressToSlice < ActiveRecord::Migration
  def self.up
    add_column :slices, :network_address_id, :integer
  end

  def self.down
    remove_column :slices, :network_address
  end
end
