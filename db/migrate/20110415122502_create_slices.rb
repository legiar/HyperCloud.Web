class CreateSlices < ActiveRecord::Migration
  def self.up
    create_table :slices do |t|
      t.string :name
      t.references :host

      t.timestamps
    end
  end

  def self.down
    drop_table :slices
  end
end
