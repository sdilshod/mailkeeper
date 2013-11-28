class ChangeEmailFileds < ActiveRecord::Migration
  def up
    rename_column :emails, :from_whom, :sender_rec
    add_column :emails, :email_address, :string
  end

  def down
    rename_column :emails, :sender_rec, :from_whom
    remove_column :email_address
  end
end
