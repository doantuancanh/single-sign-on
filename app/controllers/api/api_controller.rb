class Api::ApiController <  ActionController::API
  before_action :doorkeeper_authorize!

  def current_user
    User.find(doorkeeper_token.resource_owner_id)
  end

  def current_client
    doorkeeper_token.application
  end

  private
  def render_error(message, status = :bad_request)
    Rails.logger.warn { message }
    render json: { errors: message }, status: status
  end

  def respond_with(cmds, _opts = {})
    if cmds.success?
      render json: cmds.result, status: :ok
    else
      render_error(cmds.errors, cmds.status)
    end
  end
end
