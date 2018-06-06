Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  authenticated :user do
    root 'posts#index'
  end

  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end

  resources :conversations do
    resources :messages
  end

  resources :posts do
    collection do
      get 'user'
    end
  end

  namespace :api do
    namespace :v1 do
      devise_for :users, defaults: { format: :json }, as: :users
      resources :messages
      resources :conversations
      resources :posts do
        collection do
          match 'user', via: [:get, :post]
        end
      end
    end
  end

end
