class Award < ApplicationRecord
  belongs_to :cycle
  belongs_to :award_master
end
