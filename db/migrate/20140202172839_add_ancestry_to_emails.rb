class AddAncestryToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :ancestry, :string
    add_column :emails, :message_id, :string

    add_index :emails, :ancestry
  end
end
