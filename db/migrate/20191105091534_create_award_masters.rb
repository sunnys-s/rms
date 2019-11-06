class CreateAwardMasters < ActiveRecord::Migration[6.0]
  def change
    create_table :award_masters do |t|
      t.string :title
      t.string :award_type

      t.timestamps
    end
  end
end
