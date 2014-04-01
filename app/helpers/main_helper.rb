module MainHelper

  def previous_mail_page(collection)
    collection.first_page? ? 0 : collection.current_page - 1
  end

  def next_mail_page(collection)
    collection.last_page? ? 0 : collection.current_page + 1
  end

end
