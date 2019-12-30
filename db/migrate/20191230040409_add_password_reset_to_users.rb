class AddPasswordResetToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_password_reset_required, :boolean, default: true
  end
end
