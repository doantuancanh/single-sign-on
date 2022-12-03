module UserCmds
  class AddChild
    prepend BaseCmd

    def initialize(parent, params)
      @parent = parent
      @params = params
    end

    def call
      validate
      parent.add_child(child_params)
    end

    private

    attr_reader :parent, :client
    attr_accessor :params

    def validate
      return if parent.has_role? :parent
    end

    def child_params
      params.permit(:name, :age, :gender)
    end

  end
end
