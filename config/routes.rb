Rails.application.routes.draw do
  get 'github_repos/query/:lang', to: 'github_repos#query'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
