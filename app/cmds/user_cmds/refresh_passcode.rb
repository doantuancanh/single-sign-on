module UserCmds
  class RefreshPasscode
    prepend BaseCmd

    def initialize(parent, student_code)
      @parent = parent
      @student_code = student_code
    end

    def call
      validate
      refresh_passcode unless failure?
      Response::StudentResponse.new(student).build
    end

    private
    attr_reader :parent, :student_code

    def validate
      unless parent.has_role? :parent
        errors.add(:role, "User does not have permission!")
      end

      unless student.present?
        errors.add(:student, "Student does not exist!")
      end

      unless @parent.students.pluck(:id).include? student.id
        errors.add(:user, "User does not have permission!")
      end
    end

    def refresh_passcode
      passcode = UserPasscode.where(user_id: student.id, type: :default).first
      passcode.code = passcode.generate_passcode
      passcode.save!
    end

    def student
      @student ||= get_student
    end

    def get_student
      User.where(code: student_code).first()
    end
  end
end
