class CreateAssessments < ActiveRecord::Migration[6.0]
  def change
    create_table :assessments do |t|
      t.references :nomination, null: false, foreign_key: true
      t.text :statement
      t.text :feedback
      t.string :value_addition

      t.timestamps
    end
  end
end
