class AddAddressRangeToNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :begin_ip, :string
    add_column :networks, :end_ip, :string
  end
end
