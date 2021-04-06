Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :companies, controllers: {
    sessions: 'companies/sessions',
    passwords: 'companies/passwords',
    registrations: 'companies/registrations'
  }
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  root to: "home#index"
  resources :users
  resources :companies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
