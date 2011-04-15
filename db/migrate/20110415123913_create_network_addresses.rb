class CreateNetworkAddresses < ActiveRecord::Migration
  def self.up
    create_table :network_addresses do |t|
      t.references :network
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :network_addresses
  end
end
