Rails.application.routes.draw do

  # Homepage
  root "products#index"

  # Products listing and details
  resources :products, only: [:index, :show]

  # Categories listing and details
  resources :categories, only: [:index, :show]

  # About Us page
  get "about", to: "pages#about", as: :about

  # Rails health check
  get "up" => "rails/health#show", as: :rails_health_check

end