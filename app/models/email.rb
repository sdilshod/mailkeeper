#	t.column :date_, :datetime
#	t.column :sender_rec, :string
#	t.column :subject, :string
#	t.column :message, :text	
# t.column :email_address, string
# box_type, :string
# readed, boolean
# user_id, :integer


class Email < ActiveRecord::Base
  # attr_accessible :title, :body
  
  def self.get_latest addr, pw, box_type="inner"
    last_mail = self.where(:box_type=>box_type).order("date_ desc").first
    d_ = last_mail.blank? ? Date.new(2013,11,1) : last_mail.date_
     
  	gmail = Gmail.connect(addr, pw)
		if gmail.logged_in?
		  if box_type == "inner"
	#  	  mails = gmail.inbox.find(:unread, :after => d_)
			  mails = gmail.inbox.find(:after => d_)
			  if mails.count > 0 
			  	mails.each do |e|
			  		em_obj = self.new
			  		em_obj.date_ = e.date.to_datetime.change(:offset=>"+0000")
			  		em_obj.sender_rec = e.from[0].name
			  		em_obj.email_address = e.from[0].mailbox << "@" << e.from[0].host
			  		em_obj.subject = self.decode_of_mail e
			  		em_obj.message = self.decode_of_mail e, "body"
			  		em_obj.box_type = "inner"; em_obj.readed=false
			  		em_obj.save!
			  		# In a future must be realesed a function which changes a label @read@ or @unread@
			  	end
			  end
  	  else
	  	  mails = gmail.label("[Gmail]/Sent Mail").emails(:after => d_)
			  if mails.count > 0 
			  	mails.each do |e|
			  		em_obj = self.new
			  		em_obj.date_ = e.date.to_datetime.change(:offset=>"+0000")
			  		em_obj.sender_rec = e.to[0].name
			  		em_obj.email_address = e.to[0].mailbox << "@" << e.to[0].host
			  		em_obj.subject = self.decode_of_mail e
			  		em_obj.message = self.decode_of_mail e, "body"
			  		em_obj.box_type = "outer"
			  		em_obj.save!
			  		# In a future must be realesed a function which changes a label @read@ or @unread@
			  	end
			  end
	  	  
  	  end
  		gmail.logout  	  
  	end

  end
  
  #
  # decoding mails for google mail(gmail)
  #
  def self.decode_of_mail em, type_str="subject"
  	if type_str == "subject"
				em.subject.scan(/(=\?[a-zA-Z0-9\-]+)(\?[B|Q]\?)([a-zA-Z-0-9\/=]+)/)  	
				# what if decode is Q, i don't know
				return Base64.decode64($3).force_encoding($1.gsub(/=\?/,"")).encode("utf-8") unless $1.blank?
				return em.subject if $1.blank?
  	else
  	  body_of_mail = em.text_part.body 
  		if body_of_mail.encoding == "base64" 
  		  ch_set = em.text_part.charset
			  encoded_str = body_of_mail.encoded.gsub(/\r\n/,"")
				return Base64.decode64(encoded_str).force_encoding(ch_set).encode("utf-8").gsub(/\r\n/,"")
  		else
  		  return body_of_mail.encoded.to_s
#  		  return em.parts[1].body
  		end
  	end
  end
  
#  def self.connect_to
#  	return Gmail.connect(addr, pw)
#  end
  
  
end