class CreateCommitees < ActiveRecord::Migration[6.0]
  def change
    create_table :commitees do |t|
      t.references :cycle, null: false, foreign_key: true
      t.references :award, null: false, foreign_key: true
      t.string :level

      t.timestamps
    end
  end
end
