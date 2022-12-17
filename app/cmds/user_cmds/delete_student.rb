module UserCmds
  class DeleteStudent
    prepend BaseCmd

    def initialize(parent, student)
      @parent = parent
      @student = student
    end

    def call
      validate
      student.delete unless failure?
    end

    private
    attr_reader :parent, :student

    def validate
      unless parent.has_role? :parent
        errors.add(:code, "PERMISSION_DENIED")
      end

      unless parent.student_ids.include? student.id
        errors.add(:code, "PERMISSION_DENIED")
      end
    end

  end
end
