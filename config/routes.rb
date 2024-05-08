Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup'
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'currentuser', to: 'current_user#index'
  # get '/api/v1/posts', to: '/api/v1/post#index'

  namespace :api do
    namespace :v1 do
      resources :posts, only:[:index]
    end
  end


  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts do
          resources :comments
          resources :likes
        end
      end
    end

  end
end
