class AddSuccessDriversColumnToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :innovativeness, :boolean
    add_column :nominations, :agility, :boolean
    add_column :nominations, :responsiveness, :boolean
    add_column :nominations, :performance_driven, :boolean
    add_column :nominations, :ownership, :boolean
  end
end
