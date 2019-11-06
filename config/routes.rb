Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'authenticate', to: 'authentication#authenticate'
  resource :users, only: :create
  resources :tasks, only: %i[index create edit] do
    member do
      post :reorder
    end
  end
end
