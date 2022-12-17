class AddParanoniaGem < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :deleted_at, :datetime
    add_index :users, :deleted_at

    add_column :user_profiles, :deleted_at, :datetime
    add_index :user_profiles, :deleted_at
  end
end
