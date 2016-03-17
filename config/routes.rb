Rails.application.routes.draw do
  root 'pages#home'

  resources :events, only: [:index, :new, :create]
  get '/tickets', to: 'tickets#status', as: :tickets_status

  get '/sessions/new', to: 'sessions#new', as: :new_session
  delete '/sessions/destroy', to: 'sessions#destroy', as: :destroy_session
  match '/sessions/:provider/callback', to: 'sessions#callback', via: [:get, :post]
end
