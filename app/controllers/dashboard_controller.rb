class DashboardController < ApplicationController

  def show
    messages = Message.all(:joins => :enquiries, :group => "message_id", :select => "messages.id, keyword, count(*) as count", :order => "count desc", :limit => 10)
    @most_enquired = messages.map { |m| [m, m.count.to_i] }
  end

end
