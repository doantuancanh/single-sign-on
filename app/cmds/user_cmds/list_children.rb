module UserCmds
  class ListChild
    prepend BaseCmd

    def initialize(parent)
      @parent = parent
    end

    def call
      validate
    end

    private
    attr_reader :parent

    def validate
      return [] unless parent.has_role? :parent
    end
  end
end
