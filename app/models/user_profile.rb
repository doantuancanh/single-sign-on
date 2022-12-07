class UserProfile < ActiveRecord::Base
  enum gender: { male: 'male', female: 'female', other: 'other' }

  belongs_to :user

  # Encrypt data
  has_encrypted :phone, migrating: true
  blind_index :phone, migrating: true
end
