class AddColumnCompanyIdToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :company_id, :integer
  end
end
