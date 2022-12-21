class PasscodeStrategy < Warden::Strategies::Base
  def valid?
    passcode.present? && (passcode.type == UserPasscode::DEFAULT_TYPE || passcode.expired_date >= Time.now)
  end

  def authenticate!
    user = passcode.user
    parent = user&.parent

    if user && parent_confirmed?(parent)
      success!(user)
    else
      fail!('Invalid email or password')
    end
  end

  private

  def passcode
    get_passcode
  end

  def get_passcode
    @passcode ||= UserPasscode.where(code: params[:passcode]).first
  end

  def parent_confirmed?(parent)
    parent.confirmed? || parent.send(:confirmation_period_valid?)
  end
end
