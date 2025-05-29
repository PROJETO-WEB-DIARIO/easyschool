Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resources :alunos

  root "alunos#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
