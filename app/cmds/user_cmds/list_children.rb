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
      errors.add(:code, "PERMISSION_DENIED")
    end

    def list_students
      parent.students
    end

    def student_data
      data = {
        parent: parent.user_json,
        students: []
      }

      list_students.each do |student|
        data[:students] << Response::UserResponse.new(student).build
      end

      data
    end
  end
end
