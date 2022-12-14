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
    resource.email = 'canhdt@teky.edu.vn'
    resource.send_confirmation_instructions
    #access_token = resource.access_tokens.last

    response = Response::JsonResponse.new(Response::Message.new(200, "API execute sucessfully!"), response_payload(resource, access_token))
    render json: response.build, status: 200
  end

  def respond_failed
    response = Response::JsonResponse.new(Response::Message.new(400, resource.errors.full_messages), {})
    render json: response.build, status: 400
  end

  def response_payload(resource, access_token)
    Response::UserResponse.new(resource, access_token).build
  end
end
