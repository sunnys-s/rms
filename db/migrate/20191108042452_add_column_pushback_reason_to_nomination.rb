class AddColumnPushbackReasonToNomination < ActiveRecord::Migration[6.0]
  def change
    add_column :nominations, :pushback_reason, :text
  end
end
