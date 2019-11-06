class AddColumnStateToNavigation < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :state, :string
    add_column :nominations, :justification, :text
  end
end
