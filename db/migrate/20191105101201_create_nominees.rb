class CreateNominees < ActiveRecord::Migration[6.0]
  def change
    create_table :nominees do |t|
      t.references :nomination, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :emp_code

      t.timestamps
    end
  end
end
