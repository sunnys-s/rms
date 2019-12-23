class AwardMaster < ApplicationRecord
  has_many :awards, dependent: :destroy
  has_many :rating_scales, dependent: :destroy
  has_many :assessment_masters, dependent: :destroy
end
