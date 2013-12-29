class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.column :date_, :datetime
      t.column :from_whom, :string
      t.column :subject, :string
      t.column :message, :text
#      t.timestamps
    end
  end
end
