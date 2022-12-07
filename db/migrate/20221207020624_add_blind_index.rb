class AddBlindIndex < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_bidx, :string
    add_index :users, :email_bidx

    add_column :user_profiles, :phone_bidx, :string
    add_index :user_profiles, :phone_bidx

    add_column :user_passcodes, :code_bidx, :string
    add_index :user_passcodes, :code_bidx
  end
end
