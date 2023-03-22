Rails.application.routes.draw do
  root "sessions#new"

  # アカウント
  get "signup", to: "users#new"
  resources :users

  # ログイン
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy"

  # 利用者
  resources :useroffacilitys, only: [:index, :new, :create, :edit, :update, :destroy]

  # 事例記録
  resources :casereports, only: [:index, :new, :create, :edit, :update, :destroy]
end
