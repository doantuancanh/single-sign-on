Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      devise_for :users,
        controllers: {
          registrations: 'api/v1/users/registrations',
          sessions: 'api/v1/users/sessions'
        },
        defaults: { format: :json }
    end
  end
  scope 'v1' do
    use_doorkeeper
  end
end
