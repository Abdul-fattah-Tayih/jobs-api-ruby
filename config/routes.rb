Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :job_posts
      resources :job_applications, only: %i[index show create]
    end
  end

  root 'job_posts#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
