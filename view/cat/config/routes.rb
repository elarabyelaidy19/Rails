Rails.application.routes.draw do
 
  resources :kitties, except: :destroy
  resources :kitty_rental_requests, only: [:new, :create] do
    member do
      post :approve
      post :deny
    end
  end

  root to: redirect('/kitties')
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
