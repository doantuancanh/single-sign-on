module UserCmds
  class AddChild
    prepend BaseCmd

    def initialize(user, profile_params)
      @user = user
      @profile_params = profile_params
    end

    def call
      validate
      profile.update!(profile_params) unless failure?
      Response::UserResponse.new(user).build
    end

    private
    attr_reader: :user, :profile_params

    def validate
    end

    def profile
      @profile ||= get_profile
    end

    def get_profile
      user.profile
    end
  end
end
