class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :login, :string
      t.column :password, :string
      t.timestamps
    end

    add_column :emails, :user_id, :integer
  end
end
