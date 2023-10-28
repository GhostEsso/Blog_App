Rails.application.routes.draw do
  root "user#index"
  ressources :users, only: [:index, :show] do
    ressources :posts, only: [:index, :show]
  end
end
