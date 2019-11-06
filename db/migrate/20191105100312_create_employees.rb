class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :emp_code
      t.string :name
      t.string :email
      t.string :sbu
      t.string :unit
      t.string :department
      t.string :location
      t.string :reporting_manager_code
      t.string :reporting_manager
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
