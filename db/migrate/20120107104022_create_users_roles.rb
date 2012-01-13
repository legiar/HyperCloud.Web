class CreateUsersRoles < ActiveRecord::Migration
  def change
    create_table :roles_users, :id => false do |t|
      t.references  :role, :null => false
      t.references  :user, :null => false
    end
  end
end
