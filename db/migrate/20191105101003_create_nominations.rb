class CreateNominations < ActiveRecord::Migration[6.0]
  def change
    create_table :nominations do |t|
      t.references :award, null: false, foreign_key: true
      t.string :nomination_type

      t.timestamps
    end
  end
end
