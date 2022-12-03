class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :depth, :integer, default: 0

    add_reference :users, :parent, index: true

    add_index :users, [:username, :email], unique: true
  end
end
