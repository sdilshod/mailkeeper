#	t.column :date_, :datetime
#	t.column :sender_rec, :string
#	t.column :subject, :string
#	t.column :message, :text
# t.column :email_address, string
# box_type, :string
# readed, boolean
# user_id, :integer

class Email < ActiveRecord::Base
  attr_accessible :email_address,
                  :subject,
                  :message,
                  :date_,
                  :sender_rec,
                  :box_type,
                  :readed

  has_many :email_attachments, :dependent => :destroy
  belongs_to :user

  has_ancestry

  before_save :fill_up_feilds

  self.per_page = 10

  def self.get_latest( current_user, box_type="inner" )
    last_mail = self.where(:box_type=>box_type).order("date_ desc").first
    d_ = last_mail.blank? ? Date.new(2013,12,1) : last_mail.date_

    mail_interface = MailInterface.new current_user, d_

    mails = mail_interface.get_mails
    mails.each do |mail|
      email_addres = mail.from[0].mailbox << "@" << mail.from[0].host
      if email_addres == current_user.login
        em_obj = self.new mail_interface.convert_to_sent_hash(mail)
        em_obj.set_tree_attr mail
        em_obj.user_id=current_user.id
        em_obj.save!
      else
        em_obj = self.new mail_interface.convert_to_inbox_hash(mail)
        em_obj.user_id=current_user.id
        em_obj.save_inbox_attachments mail
        em_obj.set_tree_attr mail
        em_obj.save!
        mail.unread!
      end
    end

  end

  def save_inbox_attachments( email )
    folder = "public/system/transed"
    unless email.attachments.empty?
      email.message.attachments.each do |file|
        File.open(File.join(folder, file.filename), "w+b", 0644 ) { |f| f.write file.body.decoded }
        File.open("#{folder}/#{file.filename}") do |f|
          self.email_attachments << EmailAttachment.new(:attached_file=>f)
        end
      end
    end
  end

  def send_mail( addr, pw )
    all_is_OK=true
    Email.transaction do
      gmail = Gmail.connect addr, pw
      unless gmail.logged_in?
      	all_is_OK=false
        raise ActiveRecord::Rollback
      end
      e_a=self.email_address
      e_m=self.message
      e_sub = self.subject
      att = self.email_attachments[0].attached_file.path
      g_m = gmail.compose do
        to e_a
        subject e_sub
          body e_m
        unless att.blank?
          add_file att
        end
      end
      g_m.deliver!
    end
    all_is_OK
  end

  def set_tree_attr( mail )
    in_reply_to = mail.message.in_reply_to
    self.message_id = mail.message.message_id
    self.parent = Email.find_by_message_id in_reply_to if in_reply_to
  end

  def mark_as_read!
    self.readed=true
    self.save
  end

  private

  def fill_up_feilds
    self.date_ = Time.now if self.date_.blank?
    self.box_type = "outer" if self.box_type.blank?
  end
end
