class UserProfile < ActiveRecord::Base
  enum gender: { male: 'male', female: 'female', other: 'other' }

  belongs_to :user

  # Encrypt data
  has_encrypted :phone
  blind_index :phone

  self.ignored_columns = ["phone"]

  # validate :validate_phone, on: :create

end
