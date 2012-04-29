class Client < ActiveRecord::Base

  has_many :enquiries, :dependent => :delete_all
  
  validates_presence_of   :phone
  validates_uniqueness_of :phone

end
