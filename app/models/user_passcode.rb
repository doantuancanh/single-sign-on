class UserPasscode < ActiveRecord::Base
  belongs_to :user

  self.inheritance_column = :_type_disabled

  enum type: { default: 'default', short: 'short' }

  # Encrypt data
  has_encrypted :code
  blind_index :code
  self.ignored_columns = ["code"]

  before_validation :prepare_params

  DEFAULT_TYPE = "default"
  SHORT_TYPE = "short"

  def generate_passcode
    loop do
      passcode = SecureRandom.alphanumeric(8).upcase
      break passcode unless UserPasscode.exists?(code: passcode)
    end
  end

  private

  def prepare_params
    self.code = generate_passcode
    assign_type
    set_expired_time
  end

  def assign_type
    if self.type.blank?
      self.type = DEFAULT_TYPE
    end

  end

  def set_expired_time
    if self.type == SHORT_TYPE
      live_time = ENV["passcode_live_time"] || 60 * 60 * 24
      self.expired_date = Time.now + live_time.to_i.seconds
    end
  end
end
