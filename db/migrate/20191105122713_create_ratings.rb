class CreateRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :ratings do |t|
      t.string :title
      t.integer :value
      t.references :nomination, null: false, foreign_key: true

      t.timestamps
    end
  end
end
