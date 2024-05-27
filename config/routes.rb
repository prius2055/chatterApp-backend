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
  

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :show]
    end
  end


  namespace :api do
    namespace :v1 do
      resources :users do
        resources :posts, except: [:index, :show] do
          resources :comments
          resources :likes, except: [:destroy, :show, :update]
        end
      end
      delete '/users/:user_id/posts/:post_id/like', to: 'likes#destroy', as: 'user_post_like'
    end
  end
end
