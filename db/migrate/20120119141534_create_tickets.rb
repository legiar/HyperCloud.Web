class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string      :title, :null => false
      t.text        :details
      t.references  :group, :null => false
      t.references  :status, :null => false
      t.references  :priority, :null => false
      t.references  :author, :null => false
      t.references  :owner, :null => false
      t.datetime    :closed_at
      t.integer     :comments_count, :null => false, :default => 0
      t.timestamps
    end
    
    add_index :tickets, :group_id
    add_index :tickets, :status_id
    add_index :tickets, :priority_id
    add_index :tickets, :author_id
    add_index :tickets, :owner_id
  end
end
