#t.column :login, :string
#t.column :password, :string
#t.timestamps


class User < ActiveRecord::Base
	attr_accessible :login, :password

  validates :login, :presence => true, :uniqueness => true
end
