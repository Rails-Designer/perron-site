Rails.application.routes.draw do
  resource :search, module: :perron, path: "search.json", only: %w[show]
  resources :resources, module: :content, path: "library", only: %w[index show] do
    resource :template, path: "template.rb", module: :resources, only: %w[show]
  end
  resources :articles, path: "docs", module: :content, only: %w[index show]

  root to: "content/pages#root"
end
