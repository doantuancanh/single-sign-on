module UserCmds
  class AddChild
    prepend BaseCmd

    def initialize(parent, params)
      @parent = parent
      @params = params
    end

    def call
      validate
      student = User.add_student(@parent, student_params) unless failure?
      Response::UserResponse.new(student).build.merge(student.token_json) if student
    end

    private

    attr_reader :parent, :client
    attr_accessor :params

    def validate
      return if parent.has_role? :parent

      errors.add(:code, "PERMISSION_DENIED")
    end

    def student_params
      params.permit(:name, :birth_year, :gender, :address, :phone, :fullname, :school, :birth_day)
    end

  end
end
