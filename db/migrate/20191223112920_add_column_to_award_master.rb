class AddColumnToAwardMaster < ActiveRecord::Migration[6.0]
  def change
    add_column :award_masters, :cadre_coverage, :text, array: true, default: []
  end
end
