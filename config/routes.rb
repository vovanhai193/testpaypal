Rails.application.routes.draw do
  devise_for :users
  resources :tours do
    resources :book_tours
  end
  resources :book_tours, only: :show
  post "/book_tours/:id" => "book_tours#show"
end
