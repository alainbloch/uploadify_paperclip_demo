ActionController::Routing::Routes.draw do |map|
  map.root :controller => "photos", :action => 'index'

  map.resources :photos, :collection => { :check => :get }, :except => [:update, :edit]

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
