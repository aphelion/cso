Rails.application.routes.draw do
  root 'pages#home'

  resources :events, only: [] do
    resources :purchases, shallow: true, only: [:new, :create, :show, :edit, :update], as: 'event_purchases', controller: 'event_purchases'
    post 'purchases/calculate', to: 'event_purchases#calculate_new'
  end
  post 'purchases/:id/calculate', to: 'event_purchases#calculate_edit'

  get '/tickets', to: 'tickets#my', as: :my_tickets
  get '/admin', to: 'admin#home', as: :admin_home

  get '/sessions/new', to: 'sessions#new', as: :new_session
  delete '/sessions', to: 'sessions#destroy', as: :destroy_session
  match '/sessions/:provider/callback', to: 'sessions#callback', via: [:get, :post]
end
