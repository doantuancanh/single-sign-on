class Api::V1::ChildrenController < Api::ApiController
  respond_to :json

  def create
    child = UserCmds::AddChild.call(current_user, params).result

    response = Response::JsonResponse.new(
      Response::Message.new(200, "API execute successfully!"),
      Response::UserResponse.new(child).build
    )

    render json: response.build, status: 200
  end

  private

end
