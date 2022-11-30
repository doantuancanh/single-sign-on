class CreateUserProfile < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles do |t|
      t.string :school
      t.string :fullname
      t.string :gender
      t.references :users, null: false

      t.timestamps
    end
  end
end
