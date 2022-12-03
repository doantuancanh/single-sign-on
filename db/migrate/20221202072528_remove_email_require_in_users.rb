class RemoveEmailRequireInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :email, :string, null: true
  end
end
