Rails.application.routes.draw do
  resources :namespaces, only: %i[index show create] do
    resources :log_entries, only: %i[show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "namespaces#index"
end
