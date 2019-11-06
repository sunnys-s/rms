class AddColumnEmpCodeToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :emp_code, :string
  end
end
