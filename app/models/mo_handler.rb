class MOHandler

  NO_MESSAGE_REPLY = "We are sorry, there's no such content."

  # Process the phone number and body, and return the
  # message you want to be sent back to the phone.
  def process(phone_number, body)
    body = MOHandler.preprocess(body)

    reply   = nil
    client  = register_client(phone_number, body)
    message = find_message(body)
    
    if message
      message.enquiries.create(:client => client)
      
      send_email_response(message, client)
      reply = message.sms_body
    end
    
    return reply || NO_MESSAGE_REPLY
  end
  
  private
  
  # Registers the client and updates its email address if necessary
  def register_client(phone_number, body)
    client = Client.find_or_create_by_phone(phone_number)

    if client.email.blank?
      email = MOHandler.scan_for_email(body)
      client.update_attributes!(:email => email) unless email.blank?
    end
    
    return client
  end
  
  # Scans the message body for email
  def self.scan_for_email(body)
    return nil if body.blank?
    return body.scan(/[^\s@]+@[^@\.\s]+\.[^@\.\s]+/).first
  end
  
  def self.scan_for_keyword(body)
    return nil if body.blank?
    body.scan(/^\s*[^\s]+/).first.try(:strip)
  end
  
  # Pre-processes the message. Replaces \000 with '@' for now, as we know
  # Air2Web sends them this way at the moment.
  def self.preprocess(body)
    body.gsub("\000", '@')
  end
  
  # Finds a message
  def find_message(body)
    Message.find_by_keyword(MOHandler.scan_for_keyword(body))
  end

  # Sends an email message
  def send_email_response(message, client)
    return if message.nil? || client.nil? || message.email_body.blank? || client.email.blank?
    Postman.deliver_content(message, client)
  end
  
end