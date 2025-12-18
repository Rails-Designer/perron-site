Rails.application.routes.draw do
  resources :blas, module: :content, only: %w[show]
  resources :resources, module: :content, path: "library", only: %w[index show] do
    resource :template, path: "template.rb", module: :resources, only: %w[show]
  end
  resources :articles, path: "docs", module: :content, only: %w[index show]
  resources :pages, path: "/", module: :content, only: %w[show], constraints: { id: /[^\/]+/ }

  root to: "content/pages#root"
end
