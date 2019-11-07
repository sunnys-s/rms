class Award < ApplicationRecord
  has_many :nominations
  belongs_to :cycle
  belongs_to :award_master
end
