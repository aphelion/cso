Rails.application.routes.draw do
  root 'pages#home'

  resources :events, only: [] do
    resources :purchases, shallow: true, only: [:new, :create, :show], as: 'event_purchases', controller: 'event_purchases'
  end

  get '/tickets', to: 'tickets#my', as: :my_tickets

  get '/sessions/new', to: 'sessions#new', as: :new_session
  delete '/sessions', to: 'sessions#destroy', as: :destroy_session
  match '/sessions/:provider/callback', to: 'sessions#callback', via: [:get, :post]
end
