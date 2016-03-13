Rails.application.routes.draw do
  root 'pages#home'
  match '/auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
end
