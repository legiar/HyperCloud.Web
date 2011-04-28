class AddPasswordAndSizeToDatabase < ActiveRecord::Migration
  def self.up
    add_column :databases, :password, :string, :defailt => ''
    add_column :databases, :size, :integer, :default => 0
  end

  def self.down
    remove_column :databases, :password
    remove_column :databases, :size
  end
end
