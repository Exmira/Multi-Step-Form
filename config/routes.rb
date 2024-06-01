Rails.application.routes.draw do

  root "cars#index"
  resources :cars do
    collection do
      post 'next_step'
      post 'update_colors'
      post 'previous_step'
    end
  end

  resources :posts
end