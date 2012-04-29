class Message < ActiveRecord::Base

  has_many :enquiries, :dependent => :delete_all
  
  validates_presence_of   :keyword
  validates_uniqueness_of :keyword

  acts_as_textiled :email_body

end
