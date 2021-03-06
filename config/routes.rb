Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show,:edit,:update,:index] do
  	member do
    	get :follows, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

  resources :books do
  	resource :favorites, only: [:create, :destroy]
  	resources :book_comments, only: [:create, :destroy]
  end
  get 'search/search' #コントローラ名を複数形にし忘れた為
end