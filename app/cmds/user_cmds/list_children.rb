module UserCmds
  class ListChildren
    prepend BaseCmd

    def initialize(parent)
      @parent = parent
    end

    def call
      validate
      student_data unless failure?
    end

    private
    attr_reader :parent

    def validate
      return if parent.has_role? :parent
      errors.add(:role, "User does not have permission!")
    end

    def list_students
      parent.students
    end

    def student_data
      data = []

      list_students.each do |student|
        profile = student.profile

        data << {
          user_id: student.id,
          username: student.email,
          email: student.email,
          user_code: student.code,
          created_at: student.created_at.strftime('%H:%M:%S %d/%m/%Y'),
          passcode: student.passcodes.first&.code,
          fullname: profile.fullname,
          school: profile.school,
          gender: profile.gender,
          phone: profile.phone,
          birth_year: profile.birth_year,
          address: profile.address
        }
      end

      data
    end
  end
end
