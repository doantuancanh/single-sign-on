module UserCmds
  class ChildInfo
    prepend BaseCmd

    def initialize(student)
      @student = student
    end

    def call
      validate
      Response::StudentResponse.new(@student).build unless failure?
    end

    private
    attr_reader :student

    def validate
      return if student.has_role? :student
      errors.add(:code, "PERMISSION_DENIED")
    end
  end
end
