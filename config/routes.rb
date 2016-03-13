Rails.application.routes.draw do
  root 'pages#home'

  get '/tickets', to: 'tickets#status', as: :tickets_status

  get '/sessions/new', to: 'sessions#new', as: :sessions_new
  match '/sessions/callback/:provider', to: 'sessions#callback', via: [:get, :post]
end
