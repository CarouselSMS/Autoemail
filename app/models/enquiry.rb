class Enquiry < ActiveRecord::Base

  belongs_to :client
  belongs_to :message

  validates_presence_of :client_id
  validates_presence_of :message_id
  
end
