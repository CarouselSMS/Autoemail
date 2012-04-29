require 'test_helper'

class ClientsControllerTest < ActionController::TestCase

  context "index" do
    setup do
      login
      @c = Factory(:client)
      get :index
    end
    should_render_template :index
    should_assign_to(:clients) { [ @c ] }
  end

end
