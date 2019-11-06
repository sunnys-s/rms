class CreateAwards < ActiveRecord::Migration[6.0]
  def change
    create_table :awards do |t|
      t.references :cycle, null: false, foreign_key: true
      t.references :award_master, null: false, foreign_key: true
      t.string :title
      t.string :award_type
      t.integer :financial_year
      t.integer :half

      t.timestamps
    end
  end
end
