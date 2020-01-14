Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'
  }

  resources :users,only: [:show,:index,:edit,:update] do
  	resource :relationships, only: [:create, :destroy]
  	get :follows, on: :member
  	get :followers, on: :member
  end

  resources :books do
      resource :favorites, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
  end

  root :to => 'home#top'
  get 'home/about'

  get '/result' => 'search#search', as: 'result'

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
