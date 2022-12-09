module UserCmds
  class AddChild
    prepend BaseCmd

    def initialize(parent, params)
      @parent = parent
      @params = params
    end

    def call
      validate
      User.add_student(@parent, student_params) unless failure?
    end

    private

    attr_reader :parent, :client
    attr_accessor :params

    def validate
      return if parent.has_role? :parent

      errors.add(:role, "User does not have permission!")
    end

    def student_params
      params.permit(:name, :birth_year, :gender, :address, :phone, :fullname, :school)
    end

  end
end
