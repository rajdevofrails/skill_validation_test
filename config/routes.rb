Rails.application.routes.draw do
  resources :companies do
    resources :checks
    resources :invoices
  end
  root "companies#index"
end