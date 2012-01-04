class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.references :zone
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :spaces, :zone_id
  end
end
