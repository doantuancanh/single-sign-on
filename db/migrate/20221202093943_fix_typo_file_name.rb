class FixTypoFileName < ActiveRecord::Migration[7.0]
  def change
    remove_reference :user_passcodes, :users
    remove_reference :user_profiles, :users

    add_reference :user_passcodes, :user, index: true
    add_reference :user_profiles, :user, index: true
  end
end
