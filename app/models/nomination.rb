class Nomination < ApplicationRecord
  has_many :nominees
  has_many :ratings
  belongs_to :nominator, polymorphic: true, optional: true
  accepts_nested_attributes_for :nominees
  accepts_nested_attributes_for :ratings
  belongs_to :award
end
