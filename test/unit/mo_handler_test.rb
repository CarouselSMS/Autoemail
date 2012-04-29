require 'test_helper'

class MOHandlerTest < ActiveSupport::TestCase

  context "scanning for email" do
    should "return nil if there's no email" do
      [ "", nil, "abc" ].each do |body|
        assert_nil MOHandler.send(:scan_for_email, body)
      end
    end
    
    should "return an email if found" do
      assert_equal "my.own@email.com", MOHandler.send(:scan_for_email, " test my.own@email.com test")
    end
  end

  context "scanning for keyword" do
    should "return nil if there are no keywords" do
      [ "", nil, " " ].each do |body|
        assert_nil MOHandler.send(:scan_for_keyword, body)
      end
    end
    
    should "return the keyword" do
      assert_equal "keyword", MOHandler.send(:scan_for_keyword, " keyword my@email.com ")
    end
  end
  
  context "registering clients" do
    should "register phone-only client" do
      client = MOHandler.new.send(:register_client, "0123456789", "test")
      assert_equal  "0123456789", client.phone
      assert_nil    client.email
    end
    
    should "register client w/ email" do
      client = MOHandler.new.send(:register_client, "0123456789", "test my@email.com")
      assert_equal  "my@email.com", client.email
    end
  end
  
  context "processing the message" do
    should "create client record, and associate it with the message" do
      message = Factory(:message, :sms_body => "sms response")
      response = MOHandler.new.process("0123456789", "#{message.keyword}")
      assert_equal message.sms_body, response
      
      message.reload
      assert_equal 1, message.enquiries.size
      
      e = message.enquiries.first
      assert_equal "0123456789", e.client.phone
    end
    
    should "create client record, but send a canned response" do
      response = MOHandler.new.process("0123456789", "unknown keyword")
      assert_equal response, MOHandler::NO_MESSAGE_REPLY
      
      assert_equal "0123456789", Client.first.phone
    end
  end
  
  context "pre-processing messages" do
    should "replace \\000 with '@'" do
      assert_equal "name@test.com", MOHandler.preprocess("name\000test.com")
    end
  end
end
