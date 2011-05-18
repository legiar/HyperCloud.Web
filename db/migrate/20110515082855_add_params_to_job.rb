class AddParamsToJob < ActiveRecord::Migration
  def self.up
    add_column :jobs, :params, :string
  end

  def self.down
    remove_column :jobs, :params
  end
end
