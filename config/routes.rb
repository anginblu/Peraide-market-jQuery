Rails.application.routes.draw do

  devise_for :users

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'signin', to: 'sessions#new', as: 'signin'
  get 'categories/:id/best_profile', to: 'categories#best', as: 'best_profile'

  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  get 'register', to: 'users#new'
  post 'registered', to: 'users#create'

  resources :users, only: [:show, :edit, :update, :destroy]

  resources :profiles, only: [:show, :edit, :update, :new, :create, :index]
  resources :profiles, only: [:destroy], as: 'delete_profile'

  get 'user/profiles', to: 'profiles#user_index', as: 'my_profiles'

  resources :categories, only: [:index, :show]

  resources :profiles, only: [:show] do
    resources :skills, only: [:index, :show]
    resources :comments, only: [:index, :show, :new, :create]
  end

  root 'home#show'

end
