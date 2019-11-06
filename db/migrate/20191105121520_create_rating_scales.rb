class CreateRatingScales < ActiveRecord::Migration[6.0]
  def change
    create_table :rating_scales do |t|
      t.string :title
      t.references :award_master, null: false, foreign_key: true
      t.references :rating_scale, null: false, foreign_key: true
      t.timestamps
    end
  end
end
