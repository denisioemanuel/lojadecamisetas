Rails.application.routes.draw do
  resources :departamentos
  resources :produtos, only: [:new, :create, :destroy, :edit, :update]
  get "/produtos/busca" => "produtos#busca", as: :busca_produtos
  root "produtos#index"
end
