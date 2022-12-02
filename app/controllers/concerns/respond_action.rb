module RespondAction
  extend ActiveSupport::Concern
  

  private

  def respond_with(resource, _opts = {})
    respond_success && return if resource.persisted?

    respond_failed
  end

  def respond_success
    resource.revoke_all_token(params[:client_id])
    resource.create_access_token(params[:client_id])
    access_token = resource.access_tokens.last

    payload = {
      user_id: resource.id,
      username: resource.username,
      email: resource.email,
      created_at: resource.created_at.strftime('%H:%M:%S %d/%m/%Y'),
      access_token: access_token&.token,
      token_type: 'Bearer',
      expires_in: access_token&.expires_in,
      refresh_token: access_token&.refresh_token,
    }

    response = Response::JsonResponse.new(Response::Message.new(200, "API execute sucessfully!"), payload)
    render json: response.build, status: 200
  end

  def respond_failed
    response = Response::JsonResponse.new(Response::Message.new(400, resource.errors.full_messages), {})
    render json: response.build, status: 400
  end
end
