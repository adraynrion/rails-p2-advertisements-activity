Rails.application.routes.draw do
  get 'users/new' => 'users#new'
  post 'users/new' => 'users#create'
  get 'users/login' => 'users#login'
  post 'users/login' => 'users#check'
  delete 'users/login' => 'users#logout'

  root 'users#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
