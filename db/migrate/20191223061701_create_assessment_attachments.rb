class CreateAssessmentAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :assessment_attachments do |t|
      t.references :assessment, null: false, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
