class AddColumnDojToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :doj, :string
  end
end
