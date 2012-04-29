class MessagesController < InheritedResources::Base

  protected
  
  def collection
    @messages ||= end_of_association_chain.paginate(:page => params[:page], :order => "keyword")
  end
  
end
