class Api::ApiController <  ActionController::API
  before_action :doorkeeper_authorize!

  def current_user
    User.find(doorkeeper_token.resource_owner_id)
  end

  def current_client
    doorkeeper_token.application
  end
end
