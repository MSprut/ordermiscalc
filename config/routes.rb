Rails.application.routes.draw do
  resources :calculations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'calculations#index'
end
