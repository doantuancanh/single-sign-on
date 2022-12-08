module UserCmds
  class AddChild
    prepend BaseCmd

    def initialize(parent, params)
      @parent = parent
      @params = params
    end

    def call
      validate
      User.add_student(@parent, student_params)
    end

    private

    attr_reader :parent, :client
    attr_accessor :params

    def validate
      return unless parent.has_role? :parent
    end

    def student_params
      params.permit(:name, :birth_year, :gender, :address, :phone, :fullname, :school)
    end

  end
end
