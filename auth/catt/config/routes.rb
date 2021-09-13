Rails.application.routes.draw do
  # get 'cats/new'
  # get 'cats/index'
  # get 'cats/show'
  # get 'cats/create'
  # get 'cats/edit'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :cats, expect: :destroy 

end
