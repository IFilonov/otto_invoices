Rails.application.routes.draw do
  root to: 'application#index'
  resources :files, only: [:create]
  get '/*slug', to: 'application#index'
end
