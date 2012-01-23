class CreateTicketGroups < ActiveRecord::Migration
  def change
    create_table :ticket_groups do |t|
      t.string      :name, :null => false
      t.datetime    :disabled_at
      t.timestamps
    end
  end
end
