Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      registrations: 'users/registrations',
      sessions: 'users/sessions',
      passwords: 'users/passwords'
    }

  namespace :api do
    namespace :v1 do
      devise_for :users,
        controllers: {
          registrations: 'api/v1/users/registrations',
          sessions: 'api/v1/users/sessions',
          passwords: 'api/v1/users/passwords'
        },
      defaults: { format: :json }

      resources :students, only: %i[index update destroy create]

      get 'student', to: 'students#info'
    end
  end

  scope 'v1' do
    use_doorkeeper
  end

#  root to: 'application#home'
end
