class RemoveFieldForLockbox < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_profiles, :phone

    add_column :user_passcodes, :code_ciphertext, :text
  end
end
