class UserProfile < ActiveRecord::Base
  enum gender: { male: 'male', female: 'female', other: 'other' }

  belongs_to :user

end
