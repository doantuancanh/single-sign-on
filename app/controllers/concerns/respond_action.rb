module RespondAction
  extend ActiveSupport::Concern

  private

  def respond_with(resource, _opts = {})
    respond_success && return if resource.persisted?

    respond_failed
  end

  def respond_success
    resource.revoke_all_token(params[:client_id])
    access_token = resource.create_access_token(params[:client_id])

    render json: response_payload(resource, access_token), status: :ok
  end

  def respond_failed
    msg = { code: "INVALID_PARAMS", message: resource.errors.full_messages}
    render json: { errors: msg }, status: :bad_request
  end

  def response_payload(resource, access_token)
    Response::UserWithTokenResponse.new(resource, access_token).build
  end
end
