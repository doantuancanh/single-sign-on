class PasscodeStrategy < Warden::Strategies::Base
  def valid?
    passcode.present?
  end

  def authenticate!
    user = User.passcode(passcode)

    if user
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end

  private

  def passcode
    params['passcode']
  end
end
