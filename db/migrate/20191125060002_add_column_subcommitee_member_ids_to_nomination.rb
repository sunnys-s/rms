class AddColumnSubcommiteeMemberIdsToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :subcommitee_member_ids, :integer, array: true, default: []
  end
end
