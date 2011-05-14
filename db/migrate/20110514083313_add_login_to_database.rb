class AddLoginToDatabase < ActiveRecord::Migration
  def self.up
    add_column :databases, :login, :string, :after => :name
    
    Database.reset_column_information()
    Database.all.each do |database|
      database.login = database.name
      database.save
    end
  end

  def self.down
    remove_column :databases, :login
  end
end
