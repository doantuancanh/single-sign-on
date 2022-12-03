class UserPasscode < ActiveRecord::Base
  belongs_to :user

  self.inheritance_column = :_type_disabled

  enum type: { default: 'default', short: 'short' }

  before_validation :prepare_params

  private

  def prepare_params
    self.code = generate_passcode
    assign_type
    set_expired_time
  end

  def generate_passcode
    loop do
      passcode = SecureRandom.alphanumeric(8).upcase
      break passcode unless UserPasscode.exists?(code: passcode)
    end
  end

  def assign_type
    if self.type.blank?
      self.type = :default
    end

  end

  def set_expired_time
    live_time = ENV["passcode_live_time"] || 60 * 60 * 24
    self.expired_date = Time.now + live_time.to_i.seconds
  end
end
