Rails.application.routes.draw do
  resources :calculation_categories
  resources :customer_categories
  resources :inventory_categories
  #resources :inventories
  resources :units
  resources :accountant_preferences
  #resources :equipment
  resources :positions
  get 'static_pages/home'
  get 'static_pages/help'
  resources :calculations do
    collection do
      get 'get_unit_and_price', to: "calculations#get_unit_and_price"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home' #'calculations#index'

  resources :equipment do
    resources :equipment_parameters do
      member do
        delete 'remove_item', to: 'equipment#remove_item'
      end
    end
  end

  resources :inventories do
    resources :inventory_parameters do
      member do
        delete 'remove_item', to: 'inventories#remove_item'
      end
    end
  end
end
