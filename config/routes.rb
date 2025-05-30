Rails.application.routes.draw do
  get "dashboard", to: "dashboard#index"

  resources :classrooms
  resource :session
  resources :passwords, param: :token
  resources :alunos
  resources :users

  root "alunos#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
