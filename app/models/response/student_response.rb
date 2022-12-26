class Response::StudentResponse
  attr_accessor :student

  def initialize(student, token=nil, passcode=nil)
    @student = student
    @token = token || Doorkeeper::AccessToken.where(resource_owner_id: student.id).last
    @passcode = passcode || @student.default_passcode
  end

  def build
    {parent: parent}.merge(student.merge(student_profile).merge(student_passcode))
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

  def student_passcode
    return {} if @passcode.blank?
    { 
      passcode: @passcode.code,
      passcode_expired_at: @passcode.expired_date.to_i
    }
  end
end
