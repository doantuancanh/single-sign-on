class Response::UserResponse
  attr_accessor :user

  def initialize(user, token=nil)
    @user = user
    @token = token || Doorkeeper::AccessToken.where(resource_owner_id: user.id).last
  end

  def build
    user.merge(user_profile).merge(user_token)
  end

  def user
    @user.user_json
  end

  def user_profile
    @user.profile_json
  end

  def user_token
    @user.token_json(@token)
  end
end
