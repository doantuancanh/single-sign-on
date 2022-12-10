class Api::V1::StudentsController < Api::ApiController
  respond_to :json

  def index
    cmds = UserCmds::ListChildren.call(current_user)

    if cmds.success?
      response = Response::JsonResponse.new(
        Response::Message.new(200, "API execute successfully!"),
        cmds.result
      )
      render json: response.build, status: :ok
    else
      response = Response::JsonResponse.new(
        Response::Message.new(400, "#{cmds.errors}"),
        {}
      )
      render json: response.build, status: :method_not_allowed
    end
  end

  def info
    cmds = UserCmds::ChildInfo.call(current_user)

    if cmds.success?
      response = Response::JsonResponse.new(
        Response::Message.new(200, "API execute successfully!"),
        cmds.result
      )
      render json: response.build, status: :ok
    else
      response = Response::JsonResponse.new(
        Response::Message.new(400, "#{cmds.errors}"),
        {}
      )
      render json: response.build, status: :method_not_allowed
    end
  end

  def create
    cmds = UserCmds::AddChild.call(current_user, params)

    if cmds.success?
      response = Response::JsonResponse.new(
        Response::Message.new(200, "API execute successfully!"),
        Response::StudentResponse.new(cmds.result).build
      )

      render json: response.build, status: :ok
    else
      response = Response::JsonResponse.new(
        Response::Message.new(400, "#{cmds.errors}"),
        {}
      )
      render json: response.build, status: :method_not_allowed
    end

  end

  private

end
