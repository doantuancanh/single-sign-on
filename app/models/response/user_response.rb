class Response::UserResponse
  attr_accessor :user

  def initialize(user, token=nil)
    @user = user
    @token = token || Doorkeeper::AccessToken.where(resource_owner_id: user.id).last
  end

  def build
    user_token.merge(user_profile).merge(user_code)
  end

  def user_token
    {
      user_id: @user.id,
      username: @user.email,
      email: @user.email,
      created_at: @user.created_at.strftime('%H:%M:%S %d/%m/%Y'),
      token: @token&.token,
      token_type: 'Bearer',
      expires_in: @token&.expires_in,
      refresh_token: @token&.refresh_token,
      expired_time: (@token.created_at + @token.expires_in.seconds).to_i
    }
  end

  def user_profile
    profile = @user&.profile

    return {} if profile.blank?

    {fullname: profile.fullname, school: profile.fullname, gender: profile.gender}
  end

  def user_code
    # if @user.has_role? :parent
    #   code = @user.passcodes.where(type: :default).first()
    # else
    #   code = @user.passcodes.where(type: :short).first()
    # end

    code = @user.passcodes.where(type: :default).first()

    return {} if code.blank?
    {code: code.code, code_expired: code.expired_date}
  end
end
