module UserCmds
  class CreateShortTermPasscode
    prepend BaseCmd

    def initialize(parent, student)
      @parent = parent
      @student = student
    end

    def call
      validate
      passcode = create_short_passcode unless failure?
      Response::StudentResponse.new(@student, nil, passcode).build unless failure?
    end

    private
    attr_reader :parent, :student

    def validate
      unless parent.has_role? :parent
        errors.add(:code, "PERMISSION_DENIED")
      end

      unless student.has_role? :student
        errors.add(:code, StatusConstant::INVALID_PARAMS)
      end
    end

    def create_short_passcode
      student.create_short_passcode
    end
  end
end
