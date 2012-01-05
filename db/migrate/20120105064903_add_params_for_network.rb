class AddParamsForNetwork < ActiveRecord::Migration
  def change
    add_column :networks, :name, :string, :null => false
    add_column :networks, :cidr, :string
    add_column :networks, :vlan, :integer, :null => false, :default => 0
  end
end
