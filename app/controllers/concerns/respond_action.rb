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

    response = Response::JsonResponse.new(Response::Message.new(200, "API execute sucessfully!"), response_payload(resource, access_token))
    render json: response.build, status: 200
  end

  def respond_failed
    response = Response::JsonResponse.new(Response::Message.new(400, resource.errors.full_messages), {})
    render json: response.build, status: 400
  end

  def response_payload(resource, access_token)
    {
      user_id: resource.id,
      username: resource.email,
      email: resource.email,
      user_code: resource.code,
      created_at: resource.created_at.strftime('%H:%M:%S %d/%m/%Y'),
      access_token: access_token&.token,
      token_type: 'Bearer',
      expires_in: access_token&.expires_in,
      refresh_token: access_token&.refresh_token,
      expired_time: (access_token.created_at + access_token.expires_in.seconds).to_i
    }
  end
end
