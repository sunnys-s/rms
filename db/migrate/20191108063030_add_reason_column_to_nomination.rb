class AddReasonColumnToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :l1_approval_reason, :text
    add_column :nominations, :l1_rejection_reason, :text
  end
end
