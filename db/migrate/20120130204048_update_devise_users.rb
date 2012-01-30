class UpdateDeviseUsers < ActiveRecord::Migration
  def change
    add_column :users, :unconfirmed_email, :string, :after => :confirmation_sent_at
  end
end
