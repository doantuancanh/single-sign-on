module HasOauthToken
  extend ActiveSuport::Concern

  included do
    after_save :generate_access_token
  end

  def generate_access_token(client_id)
    auth_app = Doorkeeper::Application.where(uid: client_id).first
    return if !auth_app

    Doorkeeper::AccessToken.create(
      resource_owner_id: self.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: ''
    )

    # {
    #   access_token: access_token.token,
    #   token_type: 'bearer',
    #   expires_in: access_token.expires_in,
    #   refresh_token: access_token.refresh_token,
    #   created_at: access_token.created_at.to_time.to_i
    # }
  end

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end
end
