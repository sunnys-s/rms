class RemoveColumnAwardIdFromCommitee < ActiveRecord::Migration[6.0]
  def change
    remove_column :commitees, :award_id, :string
  end
end
