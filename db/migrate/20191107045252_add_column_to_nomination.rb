class AddColumnToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :summary, :text
    add_column :nominations, :review_feedback, :text
  end
end
