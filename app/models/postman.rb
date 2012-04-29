class Postman < ActionMailer::Base
  
  # Delivers the content
  def content(message, client)
    setup_email(client, message.email_subject || AppConfig['email_subject'])
    body          :message => message
  end
  
  private
  
  def setup_email(to, subject, from = AppConfig['email_from'])
    sent_on       Time.now
    subject       subject
    recipients    to.respond_to?(:email) ? to.email : to
    from          from
    content_type  "text/html"
  end
  
end
