Rails.application.routes.draw do
  resources :transfers
  resources :students do
  collection do
    get :export_all_pdf
  end
end
  get "dashboard", to: "dashboard#index"

  resources :classrooms
  resource :session
  resources :passwords, param: :token
  resources :users

  resources :students do
  member do
    get :export_pdf
  end
end



  root "students#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
