module StudentAction
  extend ActiveSupport::Concern

  def add_child(params)
    child = User.new(build_child_params)
    child.save!

    if child.persisted?
      create_child_profile(child, params)
      create_child_passcode(child)
      child.create_access_token(client_uid)
    end

    child
  end

  private

  def build_child_params
    password = auto_password
    {
      username: child_username,
      email: self.email,
      password: password,
      parent_id: self.id,
      depth: self.depth + 1
    }
  end

  def assign_role(child)
    child.add_role :student
    child.add_role :child
  end

  def child_username
    index = 1
    loop do
      username = "#{self.username}_child_#{index}"
      break username unless User.exists?(username: username)
      index += 1
    end
  end

  def create_child_profile(child, params)
    profile_params = {
      fullname: params[:fullname],
      school: params[:school],
      gender: params[:gender] || 'male',
      user: child
    }
    profile = UserProfile.new(profile_params)
    profile.save if profile.valid?
  end

  def create_child_passcode(child)
    UserPasscode.create!(user_id: child.id)
  end

  def auto_password
    SecureRandom.alphanumeric(8).upcase
  end

  def client_uid
    self.client&.uid
  end
end
