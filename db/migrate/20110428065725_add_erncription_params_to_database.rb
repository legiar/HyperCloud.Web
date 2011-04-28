class AddErncriptionParamsToDatabase < ActiveRecord::Migration
  def self.up
    add_column :databases, :certificate_name, :string, :default => ''
    add_column :databases, :certificate_password, :string, :default => ''
    add_column :databases, :certificate, :binary
  end

  def self.down
    remove_column :databases, :certificate_name
    remove_column :databases, :certificate_password
    remove_column :databases, :certificate
  end
end
