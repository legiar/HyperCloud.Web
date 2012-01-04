class CreateSiteErrorLogs < ActiveRecord::Migration
  def change
    create_table :site_error_logs do |t|
      t.datetime :date
      t.string :site
      t.string :site_id
      t.string :slice
      t.string :slice_id
      t.string :level, :length => 20
      t.text :message
    end
    add_index :site_error_logs, :date
    add_index :site_error_logs, :level
  end
end
