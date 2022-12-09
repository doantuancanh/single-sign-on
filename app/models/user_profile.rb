class UserProfile < ActiveRecord::Base
  enum gender: { male: 'male', female: 'female', other: 'other' }

  belongs_to :user
  belongs_to :parent, class_name: 'User', foreign_key: 'parent_id'

  # Encrypt data
  has_encrypted :phone
  blind_index :phone

  self.ignored_columns = ["phone"]

  # validate :validate_phone, on: :create

end
