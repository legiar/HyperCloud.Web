class CreateConditions < ActiveRecord::Migration
  def self.up
    create_table :conditions do |t|
      t.references :job
      t.integer :event_type
      t.string :model
      t.string :fields
      t.timestamps
    end
  end

  def self.down
    drop_table :conditions
  end
end
