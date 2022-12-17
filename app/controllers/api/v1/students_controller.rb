class Api::V1::StudentsController < Api::ApiController
  before_action :find_student, only: %i[refresh_passcode destroy]
  respond_to :json

  def index
    cmds = UserCmds::ListChildren.call(current_user)

    respond_with(cmds)
  end

  def info
    cmds = UserCmds::ChildInfo.call(current_user)

    respond_with(cmds)
  end

  def create
    cmds = UserCmds::AddChild.call(current_user, params)

    respond_with(cmds)
  end

  def refresh_passcode
    cmds = UserCmds::RefreshPasscode.call(current_user, @student)

    respond_with(cmds)
  end
  
  def destroy
    cmds = UserCmds::DeleteStudent.call(current_user, @student)

    respond_with(cmds)
  end

  private

  def find_student
    @student = User.find_by_code(params[:id])
  end

  def create_student_params
    params.permit(:school, :fullname, :gender, :birth_year, :address, :phone)
  end

  def refresh_passcode_params
    params.permit(:student_code)
  end
end
