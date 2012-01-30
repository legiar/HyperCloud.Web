class AddUsernameToUsers < ActiveRecord::Migration
  def up
    add_column :users, :name, :string, :null => false, :after => :id
    User.reset_column_information
    User.all.each do |user|
      user.name = user.email
      user.save
    end
    add_index :users, :name, :unique => true
  end
  
  def down
    remove_index :users, :name
    remove_column :users, :name
  end
end
