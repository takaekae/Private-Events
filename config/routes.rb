Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # nest the attendings routes under events to allow you to pass @event in the url to controller
  resources :events do
    post 'create_invite', to: 'invites#create'
    delete 'destroy_invite', to: 'invites#destroy'
  end

  # nesting the attendings routes under event passed the event_id to controller in addition to the
  # manually entered hash values for event and user, which causes an error. Could resolve this?
  post 'create_attending', to: 'attendings#create'
  delete 'destroy_attending', to: 'attendings#destroy'

  # sets url /my_events to show user's events
  get 'my_events', to: 'users#show'

  # Defines the root path route ("/")
  root "events#index"
end