Rails.application.routes.draw do
  resources :transfers
  resources :students do
  collection do
    get :export_all_pdf
    end
    member do
    get :export_pdf
  end
end
  get "dashboard", to: "dashboard#index"

  resources :classrooms
  resource :session
  resources :passwords, param: :token

resources :users do
  member do
    patch :avatar, to: "users#update_avatar"
  end
end


get "documents", to: "documents#index"
  post "documents/generate", to: "documents#generate", as: :generate_document


  root "students#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
