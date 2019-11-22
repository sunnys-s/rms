class Award < ApplicationRecord
  has_many :nominations
  belongs_to :cycle
  belongs_to :award_master

  def pending_count_by_location(location)
    states = ["draft", "pending"]
    p "------------------"
    self.nominations.where(nominator_id: User.user_ids_by_locations(location), state: states).size
  end

end
