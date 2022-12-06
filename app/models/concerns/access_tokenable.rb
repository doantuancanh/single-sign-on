module AccessTokenable    
  extend ActiveSupport::Concern    

  # included do
  #   after_create -> { create_access_token(client_id) }
  # end

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

  private

  def generate_refresh_token
     loop do
        token = SecureRandom.hex(32)
        break token unless Doorkeeper::AccessToken.exists?(refresh_token: token)
     end
  end
  
end