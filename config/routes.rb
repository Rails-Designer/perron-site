Rails.application.routes.draw do
  resources :articles, path: "docs", module: :content, only: %w[index show]
  resources :pages, path: "/", module: :content, only: %w[show], constraints: { id: /[^\/]+/ }

  root to: "content/pages#root"
end
