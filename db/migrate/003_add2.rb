class Add2 < ActiveRecord::Migration
  def up
    add_column :emails, :box_type, :string
    add_column :emails, :readed, :boolean
  end

  def down
    rename_column :emails, :box_type, :readed
  end
end
