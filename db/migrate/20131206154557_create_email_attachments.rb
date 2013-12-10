class CreateEmailAttachments < ActiveRecord::Migration
  def change
    create_table :email_attachments do |t|
      t.integer :email_id
      t.attachment :attached_file
      t.timestamps
    end
  end
end
