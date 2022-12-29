Rails.application.routes.draw do
  get 'new', to: "search#new", as: "new_search"
  get 'search', to: "search#search", as: "search"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
