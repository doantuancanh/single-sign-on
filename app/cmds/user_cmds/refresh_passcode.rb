module UserCmds
  class RefreshPasscode
    prepend BaseCmd

    def initialize(parent, student)
      @parent = parent
      @student = student
    end

    def call
      validate
      refresh_passcode unless failure?
      Response::StudentResponse.new(student).build
    end

    private
    attr_reader :parent, :student

    def validate
      unless student.present?
        errors.add(:code, "NOT_FOUND")
      end

      unless parent.has_role? :parent
        errors.add(:code, "PERMISSION_DENIED")
      end

      unless @parent.students.pluck(:id).include? student.id
        errors.add(:code, "PERMISSION_DENIED")
      end

    end

    def refresh_passcode
      passcode = UserPasscode.where(user_id: student.id, type: :default).first
      passcode.code = passcode.generate_passcode
      passcode.save!
    end
  end
end
