module ProfileCmds
  class UpdateProfile
    prepend BaseCmd

    def initialize(user, profile_params)
      @user = user
      @profile_params = profile_params
    end

    def call
      validate
      user.update_profile(profile_params) unless failure?
      Response::UserResponse.new(user).build
    end

    private
    attr_reader :user, :profile_params

    def validate
      true
    end
  end
end
