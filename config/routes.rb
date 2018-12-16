Rails.application.routes.draw do
  resources :inventory_categories
  resources :inventories
  resources :units
  resources :accountant_preferences
  resources :equipment
  resources :positions
  get 'static_pages/home'
  get 'static_pages/help'
  resources :calculations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home' #'calculations#index'
end
