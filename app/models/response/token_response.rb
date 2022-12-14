class Response::TokenResponse
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def build
    user.token_json
  end
end
