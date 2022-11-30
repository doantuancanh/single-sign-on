module CustomTokenResponse
  def body
    user = User.find(token.resource_owner_id)

    additional_data = {
      'username' => user.username,
      'user_id' => user.id
    }

    super.merge(additional_data)
  end
end
