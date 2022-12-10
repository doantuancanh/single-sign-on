module UserCmds
  class ChildInfo
    prepend BaseCmd

    def initialize(student)
      @student = student
    end

    def call
      validate
      Response::StudentResponse.new(@student) unless failure?
    end

    private
    attr_reader :student

    def validate
      return if student.has_role? :student
      errors.add(:role, "User does not have permission!")
    end
  end
end
