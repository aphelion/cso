Rails.application.routes.draw do
  root 'pages#home'

  resources :events, only: [:index, :new, :create, :edit, :update] do
    resources :ticket_options, only: [:index, :new, :create, :edit, :update]
    resources :tickets, shallow: true, only: [:new, :create, :show, :destroy]
    post 'tickets/calculate'
  end

  get '/tickets', to: 'tickets#my', as: :my_tickets

  get '/sessions/new', to: 'sessions#new', as: :new_session
  delete '/sessions', to: 'sessions#destroy', as: :destroy_session
  match '/sessions/:provider/callback', to: 'sessions#callback', via: [:get, :post]
end
