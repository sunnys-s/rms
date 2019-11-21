class AddColumnFunctionalManagerAndAdministrativeManagerToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :functional_manager, :string
    add_column :employees, :administrative_manager, :string
  end
end
