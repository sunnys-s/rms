class CreateCommiteeMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :commitee_members do |t|
      t.references :commitee, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :representative
      t.boolean :chairman

      t.timestamps
    end
  end
end
