class AddColumnFinalVerdictToAward < ActiveRecord::Migration[6.0]
  def change
    add_column :awards, :final_verdict, :text
  end
end
