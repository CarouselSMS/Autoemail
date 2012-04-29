require 'test_helper'

class EnquiryTest < ActiveSupport::TestCase

  should_validate_presence_of :client_id, :message_id

end
