module AuthenticationAction
  extend ActiveSupport::Concern

  included do
    has_many  :access_grants,
      class_name: 'Doorkeeper::AccessGrant',
      foreign_key: :resource_owner_id,
      dependent: :delete_all 

    has_many  :access_tokens,
      class_name: 'Doorkeeper::AccessToken',
      foreign_key: :resource_owner_id,
      dependent: :delete_all
  end

  def create_access_token(client_id)
    return unless oauth_client?(client_id)

    Doorkeeper::AccessToken.create(
      application_id: @client.id,
      resource_owner_id: self.id,
      refresh_token: generate_refresh_token,
      expires_in: Doorkeeper.configuration.access_token_expires_in.to_i,
      scopes: 'read'
    )
  end

  def oauth_client?(client_id)
    if @client.blank?
      @client = Doorkeeper::Application.where(uid: client_id).first()
    end

    @client
  end

  def client
    Doorkeeper::AccessToken.where(resource_owner_id: self.id).last&.application
  end

  def revoke_all_token(client_id)
    return unless oauth_client?(client_id)

    Doorkeeper::AccessToken.revoke_all_for(@client.id, self)
  end

  def token_json(access_token=nil)
    token = Doorkeeper::AccessToken.by_token(access_token)
    token = Doorkeeper::AccessToken.where(resource_owner_id: self.id).last if not token

    return {} if not token

    {
      token: token&.token,
      token_type: 'Bearer',
      expires_in: token&.expires_in,
      refresh_token: token&.refresh_token,
      expired_time: (token.created_at + token.expires_in.seconds).to_i
    }
  end

  private

  def generate_refresh_token
    loop do
      token = SecureRandom.hex(32)
      break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
    end
  end

end
