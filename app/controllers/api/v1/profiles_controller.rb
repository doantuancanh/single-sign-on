class Api::V1::ProfilesController < Api::ApiController
  respond_to :json

  def update
    cmds = ProfileCmds::UpdateProfile.call(current_user, profile_params)

    respond_with(cmds)
  end

  private

  def profile_params
    params.permit(:school, :fullname, :gender, :birth_year, :address)
  end
end
