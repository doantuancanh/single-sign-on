class AddBirthDayToUserProfile < ActiveRecord::Migration[7.0]
  def change
    add_column :user_profiles, :birth_day, :datetime
  end
end
