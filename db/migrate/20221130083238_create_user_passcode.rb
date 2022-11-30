class CreateUserPasscode < ActiveRecord::Migration[7.0]
  def change
    create_table :user_passcodes do |t|
      t.string :code, null: false
      t.string :type, null: false
      t.datetime :expired_date
      t.references :users, null: false

      t.timestamps
    end

    add_index :user_passcodes, :code, unique: true
  end
end
