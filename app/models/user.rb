#t.column :login, :string
#t.column :password, :string
#t.timestamps


class User < ActiveRecord::Base
  attr_accessible :login, :password

  has_many :emails do
    def clear_all_inner(user)
      Email.destroy_all(:user_id => user.id)
    end
  end

  validates :login, :presence => true, :uniqueness => true
end
