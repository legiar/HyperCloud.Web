class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string      :name, :null => false
      t.datetime    :disabled_at
      t.timestamps
    end
  end
end
