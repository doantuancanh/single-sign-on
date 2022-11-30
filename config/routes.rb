Rails.application.routes.draw do
  #devise_for :users
  #devise_for :users,
  #  path: '/v1/user',
  #  controllers: {
  #    sessions: 'api/v1/sessions',
  #    registrations: 'api/v1/registrations'
  #  }
  # use_doorkeeper
  scope :api do
    devise_for :users,
      controllers: {
        registrations: 'api/v1/users/registrations',
        sessions: 'api/v1/users/sessions'
      }
      #defaults: { format: :json }
  end
  scope 'v1' do
    use_doorkeeper
  end
end
