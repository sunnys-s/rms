class AddNominatorToNomination < ActiveRecord::Migration[6.0]
  def change
    add_reference :nominations, :nominator, polymorphic: true, index: true
  end
end
