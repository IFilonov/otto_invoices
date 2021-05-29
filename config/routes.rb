Rails.application.routes.draw do
  root to: 'application#index'
  namespace :api do
    resources :files, only: [:create]
  end
  get '/*slug', to: 'application#index'
end
