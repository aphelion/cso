Rails.application.routes.draw do
  root 'pages#home'

  resources :events, only: [:index, :new, :create, :edit, :update] do
    resources :tickets, only: [:index, :new]
  end
  get '/tickets', to: 'users#tickets', as: :user_tickets

  get '/sessions/new', to: 'sessions#new', as: :new_session
  delete '/sessions/destroy', to: 'sessions#destroy', as: :destroy_session
  match '/sessions/:provider/callback', to: 'sessions#callback', via: [:get, :post]
end
