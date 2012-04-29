require 'test_helper'

class MessagesControllerTest < ActionController::TestCase

  context "index" do
    setup { login; get :index }
    should_render_template :index
    should_assign_to(:messages)
  end
  
end
