class Response::StudentResponse
  attr_accessor :student

  def initialize(student, token=nil)
    @student = student
    @token = token || Doorkeeper::AccessToken.where(resource_owner_id: student.id).last
  end

  def build
    {parent: parent}.merge(student.merge(student_profile).merge(student_passcode).merge(student_token))
  end

  def parent
    @student.parent&.user_json
  end

  def student
    @student.user_json
  end

  def student_profile
    @student.profile_json
  end

  def student_token
    @student.token_json(@token)
  end

  def student_passcode
    { passcode: @student.default_passcode }
  end
end
