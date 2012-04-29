ActionController::Routing::Routes.draw do |map|
  
  SprocketsApplication.routes(map)
  
  map.resource  :dashboard, :controller => "dashboard"
  map.resources :messages
  map.resources :clients
  
  map.connect   "/callbacks", :controller => "callbacks"
  
  map.root      :controller => "dashboard", :action => "show"

end
