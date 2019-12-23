class AddColumnToAward < ActiveRecord::Migration[6.0]
  def change
    add_column :awards, :cadre_coverage, :text, array: true, default: []
  end
end
