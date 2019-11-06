class CreateNominationAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :nomination_attachments do |t|
      t.references :nomination, null: false, foreign_key: true
      t.string :attachment

      t.timestamps
    end
  end
end
