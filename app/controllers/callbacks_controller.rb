class CallbacksController < ApplicationController

  # Disable CSRF
  skip_before_filter :verify_authenticity_token
  skip_before_filter :authenticate

  # Entry point
  def index
    if params[:type]
      case params[:type]
      when "incoming_message"
        incoming_message
      else
        render :text => ""
      end
    else
      render :text => ""
    end
  end

  private
  
  # Incoming message processing
  def incoming_message
    phone_number = params[:phone_number]
    body         = params[:body]

    render :text => MOHandler.new.process(phone_number, body)
  end

end
