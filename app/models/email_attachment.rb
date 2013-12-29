#  t.integer :email_id
#  t.attachment :attached_file

class EmailAttachment < ActiveRecord::Base
  attr_accessible :attached_file, :email_id
  has_attached_file :attached_file
  
  belongs_to :email
end
