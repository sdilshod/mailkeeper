{
  previous_page: previous_mail_page(@emails),
  next_page: next_mail_page(@emails),
  emails:
    @emails.map do |e|
      {
        id: e.id,
        date_: e.date_,
        sender_rec: e.sender_rec,
        subject: e.subject,
        message: e.message,
        email_address: e.email_address,
        readed: e.readed,
        message_id: e.message_id,
        box_type: e.box_type
      }
    end
}.to_json
