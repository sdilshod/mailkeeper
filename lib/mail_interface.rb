class MailInterface

  # TODO: remove filter_date to current user's attribute
  def initialize( user, filter_date )
    @current_user = user
    @filter_date = filter_date
  end

  # TODO: adding column(load_time) to user table for storing last date load
  def get_mails
    gmail = Gmail.connect @current_user.login, @current_user.password
    return nil unless gmail.logged_in?

    mails = gmail.inbox.find :unread, after: @filter_date + 1
    sent_mails = gmail.label("[Gmail]/Sent Mail").find(afetr: @filter_date + 1)
    sent_mails.each { |e| mails << e }
    mails.sort_by!(&:date)

  end


  #
  # decoding mails for google mail(gmail)
  #
  # TODO: refactor
  def decode_of_mail( em, type_str = "subject")
    if type_str == "subject" || type_str == "sender_rec_name"
      return nil if type_str == "sender_rec_name" && em.from[0].name.blank?

      match_str = /(=\?[a-zA-Z0-9\-]+)(\?[B|Q]\?)([a-zA-Z-0-9\/=]+)/
      em.subject.scan(match_str) if type_str == "subject"
      em.from[0].name.scan(match_str) if type_str == "sender_rec_name"

      # TODO: implementing Q decode
      return Base64.decode64($3).force_encoding($1.gsub(/=\?/,"")).encode("utf-8") unless $1.blank?
      if $1.blank?
        return em.subject if type_str == "subject"
        return em.from[0].name if type_str == "sender_rec_name"
      end

    else
      unless em.text_part.blank?
        body_of_mail = em.text_part.body
        if body_of_mail.encoding == "base64"
          ch_set = em.text_part.charset
          encoded_str = body_of_mail.encoded.gsub(/\r\n/,"")
          return Base64.decode64(encoded_str).force_encoding(ch_set).encode("utf-8").gsub(/\r\n/,"")
        else
          return body_of_mail.encoded.to_s
  #       return em.parts[1].body
        end
      end
    end
  end

  def convert_to_inbox_hash( mail )
    {
      date_:         mail.date.to_datetime.change(:offset=>"+0000"),
      sender_rec:    decode_of_mail(mail, "sender_rec_name"),
      email_address: mail.from[0].mailbox << "@" << mail.from[0].host,
      subject:       decode_of_mail( mail ),
      message:       decode_of_mail( mail, "body" ),
      box_type:      "inbox",
      readed:        false
    }
  end

  def convert_to_sent_hash( mail )
    {
      date_:         mail.date.to_datetime.change(:offset=>"+0000"),
      sender_rec:    mail.to[0].name,
      email_address: mail.to[0].mailbox << "@" << mail.to[0].host,
      subject:       decode_of_mail( mail ),
      message:       decode_of_mail( mail, "body")
    }

  end

end
