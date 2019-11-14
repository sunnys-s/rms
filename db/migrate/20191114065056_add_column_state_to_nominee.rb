class AddColumnStateToNominee < ActiveRecord::Migration[6.0]
  def change
    add_column :nominees, :state, :string, default: 'active'
    add_column :nominees, :rejection_reason, :text
  end
end
