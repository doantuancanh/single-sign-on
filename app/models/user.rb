class User < ApplicationRecord
  include AuthenticationAction
  include HasProfile
  include StudentAction

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  devise :doorkeeper

  validate  :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            allow_blank: false,
            format: { with: /\A[^@\s]+@[^@\s]+\z/ } if false
  # validates :username,
  #           uniqueness: { case_sensitive: false },
  #           presence: true,
  #           allow_blank: false,
  #           format: { with: /\A[a-zA-Z0-9_@.]+\z/ }


  # Encrypt data
  has_encrypted :email
  blind_index :email

  before_save :generate_code

  self.ignored_columns = ["email"]

  scope :passcode, ->(passcode) { joins(:passcodes).where(passcodes: {code: passcode}).first }

  attr_writer :login

  # Login with username
  # def login
  #   @login || self.username || self.email
  # end

  # def self.find_first_by_auth_conditions(warden_conditions)
  #   conditions = warden_conditions.dup
  #   if (login = conditions.delete(:login))
  #     where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
  #   else
  #     if conditions[:username].nil?
  #       where(conditions).first
  #     else
  #       where(username: conditions[:username]).first
  #     end
  #   end
  # end

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

  def create_parent
    pass
  end
end
