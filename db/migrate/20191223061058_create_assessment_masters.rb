class CreateAssessmentMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_masters do |t|
      t.text :statement
      t.string :assessment_param
      t.references :award_master, null: false, foreign_key: true

      t.timestamps
    end
  end
end
