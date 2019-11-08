class Commitee < ApplicationRecord
  belongs_to :cycle
  # belongs_to :award

  has_many :commitee_members
  accepts_nested_attributes_for :commitee_members
end
