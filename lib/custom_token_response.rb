module CustomTokenResponse
  def body
    user = User.find(token.resource_owner_id)

    additional_data = {
      email: user.email,
      user_id: user.id,
      user_code: user.code,
      expired_time: (token.created_at + token.expires_in.seconds).to_i
    }

    super.merge(additional_data)
  end
end
