class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string      :name, :null => false
      t.text        :description
      t.timestamps
      t.datetime    :deleted_at
    end
  end
end
