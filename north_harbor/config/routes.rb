ActionController::Routing::Routes.draw do |map|
  
  
  map.resources :complaints do |complaints|
    complaints.resources :events
    complaints.resources :follow_up_actions do |follow_up_actions|
      follow_up_actions.resources :events
    end
  end

  map.resources :stores

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  
  
  map.resources :sessions

  map.resources :users

  map.root :controller => "dashboard"

  # See how all your routes lay out with "rake routes"
end
