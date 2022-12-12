class UserProfile < ActiveRecord::Base
  enum gender: { male: 'male', female: 'female', other: 'other' }

  belongs_to :user
  belongs_to :parent, class_name: 'User', foreign_key: 'parent_id'

  # Encrypt data
  has_encrypted :phone
  blind_index :phone

  self.ignored_columns = ["phone"]

  validates :phone, phone: true, if: :has_phone?

  before_save :set_region

  private

  def has_phone?
    self.phone.present?
  end

  def set_region
    if phone_changed?
      self.country_code = Phonelib.parse(self.phone).country
    end
  end
end
