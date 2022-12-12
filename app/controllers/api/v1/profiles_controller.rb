class Api::V1::ProfilesController < Api::ApiController
  respond_to :json

  def update
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

  private

  def profile_params
    params.permit(:school, :fullname, :gender, :birth_year, :address, :phone)
  end
end
