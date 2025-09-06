Rails.application.routes.draw do
  resources :pages, path: "/", module: :content, only: %w[show]

  root to: "content/pages#root"
end
