class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string      :name, :null => false
      t.string      :version, :null => false
      t.boolean     :demo, :null => false, :default => false 
      t.timestamps
    end
  end
end
