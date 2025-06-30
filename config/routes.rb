# config/routes.rb
Rails.application.routes.draw do
  resources :photos
  devise_for :users
  root "articles#index"
  
  resources :articles do
    # Routes imbriquées pour les commentaires
    resources :comments, only: [:create, :destroy] 
  end
  # ...
end