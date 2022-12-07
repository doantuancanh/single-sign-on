class RemoveCodeFromUserPasscode < ActiveRecord::Migration[7.0]
  def change
    remove_column :user_passcodes, :code
  end
end
