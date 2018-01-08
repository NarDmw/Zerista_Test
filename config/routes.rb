Rails.application.routes.draw do
  get 'sessions', to: 'sessions#index'
  root 'sessions#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
