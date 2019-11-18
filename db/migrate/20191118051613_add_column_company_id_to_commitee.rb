class AddColumnCompanyIdToCommitee < ActiveRecord::Migration[6.0]
  def change
    add_column :commitees, :company_id, :integer
  end
end
