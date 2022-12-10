class PasscodeStrategy < Warden::Strategies::Base
  def valid?
    passcode.present?
  end

  def authenticate!
    user = UserPasscode.where(code: passcode).where("expired_date > ?", Time.now).first&.user

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
