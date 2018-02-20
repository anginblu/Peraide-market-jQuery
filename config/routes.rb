Rails.application.routes.draw do

  devise_for :users

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'signin', to: 'sessions#new', as: 'signin'
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  resources :users

  resources :profiles

  get 'user/profiles', to: 'profiles#user_index', as: 'my_profiles'

  resources :categories do
    resources :skills
  end

  root 'home#show'

end
