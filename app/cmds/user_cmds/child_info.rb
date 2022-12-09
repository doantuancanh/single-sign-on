module UserCmds
  class ChildInfo
    prepend BaseCmd

    def initialize(student)
      @student = student
    end

    def call
      validate
      student_data unless failure?
    end

    private
    attr_reader :student

    def validate
      return if student.has_role? :student
      errors.add(:role, "User does not have permission!")
    end

    def parent_data
      parent = student.profile.parent
      {
        id: parent.id,
        email: parent.email,
        code: parent.code,
      }
    end

    def student_data
      profile = student.profile
      passcode = student.passcodes.where(type: :default).first
      data = []

      data << {
        parent: parent_data,
        user_id: student.id,
        username: student.email,
        email: student.email,
        user_code: student.code,
        created_at: student.created_at.strftime('%H:%M:%S %d/%m/%Y'),
        passcode: passcode.code,
        fullname: profile.fullname,
        school: profile.school,
        gender: profile.gender,
        phone: profile.phone,
        birth_year: profile.birth_year,
        address: profile.address
      }

      data
    end
  end
end
