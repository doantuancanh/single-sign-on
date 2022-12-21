class User < ApplicationRecord
  include AuthenticationAction
  include HasProfile
  include StudentAction

  rolify
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :doorkeeper,
         :confirmable

  validates  :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              allow_blank: false,
              format: { with: /\A[^@\s]+@[^@\s]+\z/ }, unless: :create_student?
  # validates :username,
  #           uniqueness: { case_sensitive: false },
  #           presence: true,
  #           allow_blank: false,
  #           format: { with: /\A[a-zA-Z0-9_@.]+\z/ }

  # Encrypt data
  has_encrypted :email
  blind_index :email

  before_save :generate_code
  after_save :add_default_role

  self.ignored_columns = ["email"]

  scope :find_by_passcode, ->(passcode) { joins(:passcodes).where(passcodes: {code: passcode}).first }

  attr_writer :login

  def create_student?
    self.email.blank?
  end

  def add_default_role
    self.add_role :parent
  end

  def students
    User.includes(:passcodes, :profile)
        .where(profile: { parent_id: self.id })
        .where(passcodes: {type: UserPasscode::DEFAULT_TYPE})
        .all()
  end


  def generate_code
    if code.blank?
      loop do
        self.code = SecureRandom.alphanumeric(8).upcase
        break code unless User.exists?(code: code)
      end
    end
  end

  def will_save_change_to_email?
    false
  end

  def user_json
    {
      user_id: self.id,
      username: self.email,
      email: self.email,
      user_code: self.code,
      created_at: self.created_at.strftime('%H:%M:%S %d/%m/%Y'),
      confirmed: self.confirmed_at ? true : false,
      passcode: self.default_passcode
    }
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

end
