class AddApproversAndRejectorsColumnToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :approvers, :integer, array: true, default: []
    add_column :nominations, :rejectors, :integer, array: true, default: []
  end
end
