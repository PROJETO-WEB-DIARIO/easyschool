Rails.application.routes.draw do
  resources :transfers
  resources :students
  get "dashboard", to: "dashboard#index"

  resources :classrooms
  resource :session
  resources :passwords, param: :token
  resources :students
  resources :users

  root "students#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
