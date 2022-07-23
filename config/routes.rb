Rails.application.routes.draw do
  root 'homes#top'
  devise_for :users
  resources :users do
    resources :relationships, only: [:create, :destroy]
    # on: :memberと書くことで、ルーティングにidを持たせることができる
    get :followings, on: :member
    get :followers, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
