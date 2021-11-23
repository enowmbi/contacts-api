Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root "contacts#index"
      resources :contact
    end
  end
end
