Rails.application.routes.draw do
  resources :sessions, only: [:create]
  resources :registrations, only: [:create]
  scope module: 'resources' do
    resources :movies, only: [:index, :create, :update]
  end

  get "random" => "randoms#index"
end
