class CreateCycles < ActiveRecord::Migration[6.0]
  def change
    create_table :cycles do |t|
      t.string :title
      t.string :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
