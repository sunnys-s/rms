class AddColumnDateToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :date, :date
  end
end
