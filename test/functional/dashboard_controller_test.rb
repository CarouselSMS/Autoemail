require 'test_helper'

class DashboardControllerTest < ActionController::TestCase

  context "most enquired" do
    setup do
      login
      @m1 = Factory(:message)
      @m2 = Factory(:message)
      @m3 = Factory(:message)
      
      5.times { Factory(:enquiry, :message => @m1) }
      2.times { Factory(:enquiry, :message => @m2) }
      4.times { Factory(:enquiry, :message => @m3) }
      
      get :show
    end
    
    should_render_template :show
    should_assign_to(:most_enquired) { [ [@m1, 5], [@m3, 4], [@m2, 2] ] }
  end

end
