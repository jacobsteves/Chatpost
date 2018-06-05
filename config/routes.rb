Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  devise_for :users

  authenticated :user do
    root 'users#index'
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


end
