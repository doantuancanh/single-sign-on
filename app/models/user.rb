class User < ApplicationRecord
  include AccessTokenable
  include HasChildrenable

  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username,
            uniqueness: { case_sensitive: false },
            presence: true,
            allow_blank: false,
            format: { with: /\A[a-zA-Z0-9_@.]+\z/ }

  has_many :access_grants,
           class_name: 'Doorkeeper::AccessGrant',
           foreign_key: :resource_owner_id,
           dependent: :delete_all 

  has_many :access_tokens,
           class_name: 'Doorkeeper::AccessToken',
           foreign_key: :resource_owner_id,
           dependent: :delete_all

  has_many :passcodes, class_name: "UserPasscode", dependent: :destroy
  has_one :profile, class_name: "UserProfile", dependent: :destroy

  before_validation :set_username, on: :create

  scope :passcode, ->(passcode) { joins(:passcodes).where(passcodes: {code: passcode}).first }

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def set_username
    if username.blank?
      self.username = email
    end
  end

  def will_save_change_to_email?
    false
  end
end
