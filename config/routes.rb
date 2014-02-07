Jobhunter::Application.routes.draw do

  resources :events

  root 'opportunities#index'

  resources :states

  resources :opportunities

  resources :recruiters

  resources :contacts
  
  # AJAX routes
  post 'ajax/states/update_order', to:'states#update_order'
  post 'ajax/google/send', to: 'google_client#send_to_google'

  # OmniAuth
  match '/auth/:provider/callback', to: 'google_client#authenticate', via: [:get, :post] 
  get '/auth/disconnect', to: 'google_client#disconnect'
  
  # Last ditch handle OPTIONS request
  match '/:options_test', to: 'application#handle_options', via: [:options]
end
