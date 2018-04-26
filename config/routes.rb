Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root  'home#index'

  ## Users
  resources :users
  get 'ladder'                    => "users#ladder"
  post 'authenticate'             => "users#authenticate"
  # -------------

  ## Users
  resources :genders, only: [:index, :show]
  get 'genders/by_name/:name'     => "genders#get_gender_by_name",  as: :get_gender_by_name
  # -------------

  ## Addresses
  resources :addresses, only: [:show]
  post 'validate-addr'            => 'addresses#get_valid_addr'
  # -------------

  ## Payments
  resources :payments, only: [:create]
  # -------------

end
