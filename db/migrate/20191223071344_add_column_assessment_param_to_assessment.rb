class AddColumnAssessmentParamToAssessment < ActiveRecord::Migration[6.0]
  def change
    add_column :assessments, :assessment_param, :string
  end
end
