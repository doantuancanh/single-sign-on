module CustomTokenResponse
  def body
    user = User.find(token.resource_owner_id)

    additional_data = {
      'username' => user.username,
      'user_id' => user.id,
      'expired_time' => (token.created_at + token.expires_in.seconds).to_i
    }

    super.merge(additional_data)
  end
end
