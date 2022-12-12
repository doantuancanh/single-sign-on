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
      render json: response.build, status: :not_acceptable
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
      render json: response.build, status: :not_acceptable
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
      render json: response.build, status: :not_acceptable
    end

  end

  def refresh_passcode
    cmds = UserCmds::RefreshPasscode.call(current_user, refresh_passcode_params[:student_code])

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
      render json: response.build, status: :not_acceptable
    end
  end

  private

  def create_student_params
    params.permit(:school, :fullname, :gender, :birth_year, :address, :phone)
  end

  def refresh_passcode_params
    params.permit(:student_code)
  end

end
