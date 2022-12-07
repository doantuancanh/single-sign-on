class AddFieldsToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :email_ciphertext, :text

    rename_column :users, :username, :code

    remove_column :users, :parent_id
    remove_column :users, :depth

    add_column :user_profiles, :phone, :string, null: true
    add_column :user_profiles, :phone_ciphertext, :text
    add_column :user_profiles, :country_code, :string, null: true
    add_column :user_profiles, :birth_year, :string, null: true
    add_column :user_profiles, :address, :text, null: true

    add_column :user_passcodes, :phone_ciphertext, :text

    add_reference :user_profiles, :parent, foreign_key: { to_table: :users }
  end
end
