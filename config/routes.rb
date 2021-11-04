Rails.application.routes.draw do

  get 'report/index'
  namespace :api do
    namespace :v1 do
      resources :employees
      resources :reports
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
