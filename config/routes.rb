Rails.application.routes.draw do
  root :to => 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'declined_charge' => 'home#declined_charge', as: 'declined_charge'
  get 'billing/index'
  get 'billing/confirm'
  get 'billing/error'
  get 'billing/declined'
end
